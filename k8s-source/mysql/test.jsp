<!-- 로컬 정보 -->
Local IP : <%= request.getRemoteAddr() %><br>
Local Host : <%= request.getRemoteHost() %><br>

<!-- 서버의 기본 경로 -->
Context : <%= request.getContextPath() %> <br>
URL : <%= request.getRequestURL() %> <br>
URI : <%= request.getRequestURI() %> <br>
Path : <%= request.getServletPath() %><br>
Server Port : <%= request.getServerPort() %><br><br>
