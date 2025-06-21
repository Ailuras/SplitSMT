(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1503 0)
(declare-sort var911 0)
(declare-sort var1133 0)
(declare-sort var2354 0)
(declare-sort var2129 0)
(declare-sort var3181 0)
(declare-sort var2239 0)
(declare-sort var3561 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var911-to-var2129 (var911) var2129)
(declare-fun cast-from-var1133-to-var3181 (var1133) var3181)
(declare-fun getProtocol/-383437256 (var2239) String)
(declare-fun var2129_getProtocol/-1459351703 (var2129) String)
(declare-fun mappingRegistry/-169562487 (var1503) var3561)
(declare-fun var2129_getRequestURI/-1504339324 (var2129) String)
(declare-fun var2129_getMethod/-1074735744 (var2129) String)
(declare-fun var3561_exists/1670402595 (var3561 String String) Bool)
(declare-fun handleHttp1/223584651 (var1503 var2129 var3181) void)
(declare-const null-var1503 var1503)
(declare-const null-var911 var911)
(declare-const null-var1133 var1133)
(declare-const null-var2354 var2354)
(declare-const var2239-HTTP2 var2239)
(declare-const var2428 var1503) ; Statement: r7 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter 
(assert (not (= var2428 null-var1503)))
(declare-const var3405 var911) ; Statement: r0 := @parameter0: javax.servlet.ServletRequest 
(assert (not (= var3405 null-var911)))
(declare-const var3520 var1133) ; Statement: r2 := @parameter1: javax.servlet.ServletResponse 
(assert (not (= var3520 null-var1133)))
(declare-const var3811 var2354) ; Statement: r11 := @parameter2: javax.servlet.FilterChain 
(assert (not (= var3811 null-var2354)))
(define-const var1000 var2129 (cast-from-var911-to-var2129 var3405)) ; Statement: r1 = (javax.servlet.http.HttpServletRequest) r0 
(define-const var3328 var3181 (cast-from-var1133-to-var3181 var3520)) ; Statement: r3 = (javax.servlet.http.HttpServletResponse) r2 
(define-const var789 var2239 var2239-HTTP2) ; Statement: $r4 = <org.apache.dubbo.remoting.http12.HttpVersion: org.apache.dubbo.remoting.http12.HttpVersion HTTP2> 
(assert true)
(define-const var3780 String (getProtocol/-383437256 var789)) ; Statement: $r6 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.HttpVersion: java.lang.String getProtocol()>() 
(define-const var832 String (var2129_getProtocol/-1459351703 var1000)) ; Statement: $r5 = interfaceinvoke r1.<javax.servlet.http.HttpServletRequest: java.lang.String getProtocol()>() 
(assert true)
(define-const var2722 Bool (= var3780 var832)) ; Statement: z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5) 
 ; Statement: if z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry> 
(assert (= (ite var2722 1 0) 0)) ; Cond: z0 == 0 
(define-const var125 var3561 (mappingRegistry/-169562487 var2428)) ; Statement: $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry> 
(define-const var1167 String (var2129_getRequestURI/-1504339324 var1000)) ; Statement: $r10 = interfaceinvoke r1.<javax.servlet.http.HttpServletRequest: java.lang.String getRequestURI()>() 
(define-const var1867 String (var2129_getMethod/-1074735744 var1000)) ; Statement: $r9 = interfaceinvoke r1.<javax.servlet.http.HttpServletRequest: java.lang.String getMethod()>() 
(define-const var650 Bool (var3561_exists/1670402595 var125 var1167 var1867)) ; Statement: $z1 = interfaceinvoke $r8.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: boolean exists(java.lang.String,java.lang.String)>($r10, $r9) 
 ; Statement: if $z1 == 0 goto $r15 = (javax.servlet.ServletRequest) r1 
(assert (not (= (ite var650 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
;(assert (handleHttp1/223584651 var2428 var1000 var3328)) ; Statement: specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: void handleHttp1(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse)>(r1, r3) 

(declare-const var2428!1 var1503)
(declare-const var1000!1 var2129)
(declare-const var3328!1 var3181)
 ; Statement: return 
(check-sat)
; {cast-from-var911-to-var2129=([javax.servlet.ServletRequest], javax.servlet.http.HttpServletRequest), cast-from-var1133-to-var3181=([javax.servlet.ServletResponse], javax.servlet.http.HttpServletResponse), getProtocol/-383437256=([org.apache.dubbo.remoting.http12.HttpVersion], java.lang.String), var2129_getProtocol/-1459351703=([javax.servlet.http.HttpServletRequest], java.lang.String), mappingRegistry/-169562487=([org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter], org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry), var2129_getRequestURI/-1504339324=([javax.servlet.http.HttpServletRequest], java.lang.String), var2129_getMethod/-1074735744=([javax.servlet.http.HttpServletRequest], java.lang.String), var3561_exists/1670402595=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, java.lang.String, java.lang.String], boolean), handleHttp1/223584651=([org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse], void)}
; {var1503=org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter, var2428=r7, var911=javax.servlet.ServletRequest, var3405=r0, var1133=javax.servlet.ServletResponse, var3520=r2, var2354=javax.servlet.FilterChain, var3811=r11, var2129=javax.servlet.http.HttpServletRequest, var1000=r1, var3181=javax.servlet.http.HttpServletResponse, var3328=r3, var2239=org.apache.dubbo.remoting.http12.HttpVersion, var789=$r4, var3780=$r6, var832=$r5, var2722=z0, var3561=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, var125=$r8, var1167=$r10, var1867=$r9, var650=$z1}
; {org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter=var1503, r7=var2428, javax.servlet.ServletRequest=var911, r0=var3405, javax.servlet.ServletResponse=var1133, r2=var3520, javax.servlet.FilterChain=var2354, r11=var3811, javax.servlet.http.HttpServletRequest=var2129, r1=var1000, javax.servlet.http.HttpServletResponse=var3181, r3=var3328, org.apache.dubbo.remoting.http12.HttpVersion=var2239, $r4=var789, $r6=var3780, $r5=var832, z0=var2722, org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry=var3561, $r8=var125, $r10=var1167, $r9=var1867, $z1=var650}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter;	r0 := @parameter0: javax.servlet.ServletRequest;	r2 := @parameter1: javax.servlet.ServletResponse;	r11 := @parameter2: javax.servlet.FilterChain;	r1 = (javax.servlet.http.HttpServletRequest) r0;	r3 = (javax.servlet.http.HttpServletResponse) r2;	$r4 = <org.apache.dubbo.remoting.http12.HttpVersion: org.apache.dubbo.remoting.http12.HttpVersion HTTP2>;	$r6 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.HttpVersion: java.lang.String getProtocol()>();	$r5 = interfaceinvoke r1.<javax.servlet.http.HttpServletRequest: java.lang.String getProtocol()>();	z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5);	if z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry>;	$r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry>;	$r10 = interfaceinvoke r1.<javax.servlet.http.HttpServletRequest: java.lang.String getRequestURI()>();	$r9 = interfaceinvoke r1.<javax.servlet.http.HttpServletRequest: java.lang.String getMethod()>();	$z1 = interfaceinvoke $r8.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: boolean exists(java.lang.String,java.lang.String)>($r10, $r9);	if $z1 == 0 goto $r15 = (javax.servlet.ServletRequest) r1;	specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: void handleHttp1(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse)>(r1, r3);	return
;block_num 3