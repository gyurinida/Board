package Controller.commons.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Component      // Spring bean으로 인식되기 위함
@Aspect         // AOP 기능을 하는 클래스에 반드시 추가해야 함
public class LogAdvice {
    private static final Logger logger = LoggerFactory.getLogger(LogAdvice.class);

    // @Around: 메소드 실행 전체를 앞, 뒤로 감싸서 특정 기능 실행하는 Advice
    // execution: Pointcut을 지정하는 AspectJ의 문법. AOP 적용 중 가장 주의가 필요한 부분
    @Around("execution(* Controller..*Controller.*(..)) " +
            " || execution(* Controller..service..*Impl.*(..))" +
            " || execution(* Controller..persistence..*Impl.*(..))")
    public Object logPrint(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {
        // @Around는 반드시 리턴타입이 Object여야 함
        // ProceedingJoinPoint: JoinPoint의 하위 인터페이스. Around 타입의 Advice 메소드의 파라미터로 사용되는 인터페이스

        long start = System.currentTimeMillis();
        // proceed(): 다음 Advice를 실행하거나, 실제 target객체 메소드를 실행
        Object result = proceedingJoinPoint.proceed();

        // getSigniture(): 실행하는 대상 객체의 메소드에 대한 정보 get
        String type = proceedingJoinPoint.getSignature().getDeclaringTypeName();
        String name = "";

        if(type.contains("Controller"))
            name = "Controller: ";
        else if(type.contains("Service"))
            name = "Service: ";
        else if(type.contains("DAO"))
            name = "Persistence: ";

        long end = System.currentTimeMillis();

        logger.info(name + type + "." + proceedingJoinPoint.getSignature().getName()+"()");
        logger.info("Argument/Parameter: "+ Arrays.toString(proceedingJoinPoint.getArgs()));
        logger.info("Running Time: "+(end-start));
        logger.info("---------------------------------------");

        return result;
    }
}
