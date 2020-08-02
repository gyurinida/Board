<%--
  Created by IntelliJ IDEA.
  User: gyurin
  Date: 24/07/2020
  Time: 2:43 오전
  To change this template use File | Settings | File Templates.
  Usage: 페이지의 left side column에 해당하는 부분
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

        <!-- Sidebar user panel (optional) -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
                <p>Alexander Pierce</p>
                <!-- Status -->
                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>

        <!-- search form (Optional) -->
        <form action="#" method="get" class="sidebar-form">
            <div class="input-group">
                <input type="text" name="q" class="form-control" placeholder="Search...">
                <span class="input-group-btn">
              <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
              </button>
            </span>
            </div>
        </form>
        <!-- /.search form -->

        <!-- Sidebar Menu -->
        <ul class="sidebar-menu" data-widget="tree">
            <li class="header">메뉴</li>
            <!-- Optionally, you can add icons to the links -->
            <li class="active"><a href="${path}/article/write"><i class="fa fa-edit"></i> <span>게시글 작성</span></a></li>
            <li><a href="${path}/article/list"><i class="fa fa-list"></i> <span>게시글 목록</span></a></li>
            <li><a href="${path}/article/listCriteria"><i class="fa fa-list"></i> <span>게시글 목록(페이징 처리)</span></a></li>
            <li><a href="${path}/article/listPaging"><i class="fa fa-list"></i> <span>게시글 목록(페이징, 페이지번호)</span></a></li>

            <!--<li class="treeview">
                <a href="#"><i class="fa fa-link"></i> <span>Multilevel</span>
                    <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="#">Link in level 2</a></li>
                    <li><a href="#">Link in level 2</a></li>
                </ul>
            </li>-->
        </ul>
        <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
</aside>