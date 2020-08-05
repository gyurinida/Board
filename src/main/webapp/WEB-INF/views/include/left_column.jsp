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
            <li class="treeview">
                <a href="#"><i class="fa fa-edit"></i> <span>게시판(기본)</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="${path}/article/write">게시글 쓰기</a></li>
                    <li><a href="${path}/article/list">게시글 목록</a></li>
                    <li><a href="${path}/article/listCriteria">게시글 목록(일부)</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#"><i class="fa fa-edit"></i> <span>게시판(페이징)</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="${path}/article/paging/write">게시글 쓰기</a></li>
                    <li><a href="${path}/article/paging/list">게시글 목록</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#"><i class="fa fa-edit"></i> <span>게시판(페이징+검색)</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="${path}/article/paging/search/write">게시글 쓰기</a></li>
                    <li><a href="${path}/article/paging/search/list">게시글 목록</a></li>
                </ul>
            </li>

        </ul>
        <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
</aside>