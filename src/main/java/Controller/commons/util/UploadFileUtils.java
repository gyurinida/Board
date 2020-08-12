package Controller.commons.util;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

public class UploadFileUtils {
    private static final Logger logger = LoggerFactory.getLogger(UploadFileUtils.class);

    // 파일 업로드 처리
    public static String uploadFile(MultipartFile file, HttpServletRequest request) throws Exception{

        String originalFileName = file.getOriginalFilename();
        byte[] fileData = file.getBytes();

        // 1. 파일명 중복 방지 처리
        String uuidFileName = getUuidFileName(originalFileName);

        // 2. 파일 업로드 경로 설정
        String rootPath = getRootPath(originalFileName, request);   // 기본 경로 추출
        String dataPath = getDataPath(rootPath);    // 날짜 경로 추출, 날짜 폴더 생성

        // 3. 서버에 파일 저장
        File target = new File(rootPath+dataPath, uuidFileName); // 파일 객체 생성
        FileCopyUtils.copy(fileData, target);   // 파일 객체에 파일 데이터 복사

        // 4. 이미지 파일인 경우 썸네일 이미지 생성
        if(MediaUtils.getMediaType(originalFileName)!=null){
            uuidFileName = makeThumbnail(rootPath, dataPath, uuidFileName);
        }

        // 5. 파일 저장 경로 치환
        return replaceSavedFilePath(dataPath, uuidFileName);
    }

    // 기본 경로 추출
    private static String getRootPath(String fileName, HttpServletRequest request) {
        String rootPath = "/resources/upload";
        MediaType mediaType = MediaUtils.getMediaType(fileName);
        if(mediaType!=null)
            return request.getSession().getServletContext().getRealPath(rootPath+"/images");
        return request.getSession().getServletContext().getRealPath(rootPath+"/files");
    }

    // 날짜 폴더명 추출
    private static String getDataPath(String uploadPath) {
        Calendar calendar = Calendar.getInstance();
        String yearPath = File.separator + calendar.get(Calendar.YEAR);
        String monthPath = yearPath + File.separator + new DecimalFormat("00").format(calendar.get(Calendar.MONTH)+1);
        String datePath = monthPath + File.separator + new DecimalFormat("00").format(calendar.get(Calendar.DATE));

        makeDateDir(uploadPath, yearPath, monthPath, datePath);

        return datePath;
    }

    // 날짜별 폴더 생성
    private static void makeDateDir(String uploadPath, String... paths) {

        // 날짜별 폴더가 이미 존재
        if(new File(uploadPath+paths[paths.length-1]).exists())
            return;

        for(String path: paths){
            File dirPath = new File(uploadPath+path);
            if(!dirPath.exists())
                dirPath.mkdir();
        }
    }

    // 파일 저장 경로 치환
    private static String replaceSavedFilePath(String datePath, String fileName){
        String savedFilePath = datePath + File.separator + fileName;
        return savedFilePath.replace(File.separatorChar, '/');
    }

    // 파일명 중복 방지 처리
    private static String getUuidFileName(String originalFileName){
        return UUID.randomUUID().toString()+"_"+originalFileName;
    }

    // 썸네일 이미지 생성
    private static String makeThumbnail(String uploadRootPath, String datePath, String fileName) throws Exception{

        // 원본 이미지 메모리에 로딩
        BufferedImage originalImg = ImageIO.read(new File(uploadRootPath+datePath, fileName));
        // 원본이미지 축소
        BufferedImage thumbnailImg = Scalr.resize(originalImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);

        String thumbnailImgName = "s_" + fileName;
        String fullPath = uploadRootPath+datePath+File.separator+thumbnailImgName;
        File newFile = new File(fullPath);
        String formatName = MediaUtils.getFormatName(fileName);
        ImageIO.write(thumbnailImg, formatName, newFile);

        return thumbnailImgName;
    }

    // 파일 삭제 처리
    public static void deleteFile(String fileName, HttpServletRequest request){

        String rootPath = getRootPath(fileName, request);

        // 1. 원본 이미지 파일 삭제
        MediaType mediaType = MediaUtils.getMediaType(fileName);
        if(mediaType!=null){
            String originalImg = fileName.substring(0, 12) + fileName.substring(14);
            new File(rootPath+originalImg.replace('/', File.separatorChar)).delete();
        }

        // 2. 파일 삭제(썸네일 이미지 or 일반 파일)
        new File(rootPath+fileName.replace('/', File.separatorChar)).delete();
    }

    // 파일 출력을 위한 HttpHeader 설정
    public static HttpHeaders getHttpHeaders(String fileName) throws Exception{
        MediaType mediaType = MediaUtils.getMediaType(fileName);    // 파일 타입 확인
        HttpHeaders httpHeaders = new HttpHeaders();

        // 이미지 파일 존재
        if(mediaType!=null){
            httpHeaders.setContentType(mediaType);
            return httpHeaders;
        }

        // 이미지 파일 존재 X
        fileName = fileName.substring(fileName.indexOf("_")+1); // UUID제거
        httpHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM); // 다운로드 MIME 타입 설정
        // 파일명 한글 인코딩철;
        httpHeaders.add("Content-Disposition",
                        "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"),
                        "ISO-8859-1")+"\"");

        return httpHeaders;
    }
}
