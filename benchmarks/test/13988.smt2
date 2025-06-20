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

(declare-sort var3616 0)
(declare-sort var484 0)
(declare-sort var104 0)
(declare-sort var1931 0)
(declare-sort var3099 0)
(declare-sort var636 0)
(declare-sort var1114 0)
(declare-sort var1286 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var484-to-var3099 (var484) var3099)
(declare-fun cast-from-var104-to-var636 (var104) var636)
(declare-fun getProtocol/-383437256 (var1114) String)
(declare-fun var3099_getProtocol/-1459351703 (var3099) String)
(declare-fun mappingRegistry/-169562487 (var3616) var1286)
(declare-fun var3099_getRequestURI/-1504339324 (var3099) String)
(declare-fun var3099_getMethod/-1074735744 (var3099) String)
(declare-fun var1286_exists/1670402595 (var1286 String String) Bool)
(declare-fun cast-from-var3099-to-var484 (var3099) var484)
(declare-fun cast-from-var636-to-var104 (var636) var104)
(declare-fun var1931_doFilter/1408701348 (var1931 var484 var104) void)
(declare-const null-var3616 var3616)
(declare-const null-var484 var484)
(declare-const null-var104 var104)
(declare-const null-var1931 var1931)
(declare-const var1114-HTTP2 var1114)
(declare-const var505 var3616) ; Statement: r7 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter 
(assert (not (= var505 null-var3616)))
(declare-const var1761 var484) ; Statement: r0 := @parameter0: javax.servlet.ServletRequest 
(assert (not (= var1761 null-var484)))
(declare-const var2501 var104) ; Statement: r2 := @parameter1: javax.servlet.ServletResponse 
(assert (not (= var2501 null-var104)))
(declare-const var2671 var1931) ; Statement: r11 := @parameter2: javax.servlet.FilterChain 
(assert (not (= var2671 null-var1931)))
(define-const var582 var3099 (cast-from-var484-to-var3099 var1761)) ; Statement: r1 = (javax.servlet.http.HttpServletRequest) r0 
(define-const var1166 var636 (cast-from-var104-to-var636 var2501)) ; Statement: r3 = (javax.servlet.http.HttpServletResponse) r2 
(define-const var1806 var1114 var1114-HTTP2) ; Statement: $r4 = <org.apache.dubbo.remoting.http12.HttpVersion: org.apache.dubbo.remoting.http12.HttpVersion HTTP2> 
(assert true)
(define-const var2648 String (getProtocol/-383437256 var1806)) ; Statement: $r6 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.HttpVersion: java.lang.String getProtocol()>() 
(define-const var2238 String (var3099_getProtocol/-1459351703 var582)) ; Statement: $r5 = interfaceinvoke r1.<javax.servlet.http.HttpServletRequest: java.lang.String getProtocol()>() 
(assert true)
(define-const var3026 Bool (= var2648 var2238)) ; Statement: z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5) 
 ; Statement: if z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry> 
(assert (= (ite var3026 1 0) 0)) ; Cond: z0 == 0 
(define-const var3189 var1286 (mappingRegistry/-169562487 var505)) ; Statement: $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry> 
(define-const var225 String (var3099_getRequestURI/-1504339324 var582)) ; Statement: $r10 = interfaceinvoke r1.<javax.servlet.http.HttpServletRequest: java.lang.String getRequestURI()>() 
(define-const var417 String (var3099_getMethod/-1074735744 var582)) ; Statement: $r9 = interfaceinvoke r1.<javax.servlet.http.HttpServletRequest: java.lang.String getMethod()>() 
(define-const var3095 Bool (var1286_exists/1670402595 var3189 var225 var417)) ; Statement: $z1 = interfaceinvoke $r8.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: boolean exists(java.lang.String,java.lang.String)>($r10, $r9) 
 ; Statement: if $z1 == 0 goto $r15 = (javax.servlet.ServletRequest) r1 
(assert (= (ite var3095 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1202 var484 (cast-from-var3099-to-var484 var582)) ; Statement: $r15 = (javax.servlet.ServletRequest) r1 
(define-const var1728 var104 (cast-from-var636-to-var104 var1166)) ; Statement: $r16 = (javax.servlet.ServletResponse) r3 
;(assert (var1931_doFilter/1408701348 var2671 var1202 var1728)) ; Statement: interfaceinvoke r11.<javax.servlet.FilterChain: void doFilter(javax.servlet.ServletRequest,javax.servlet.ServletResponse)>($r15, $r16) 

(declare-const var2671!1 var1931)
(declare-const var1202!1 var484)
(declare-const var1728!1 var104)
 ; Statement: return 
(check-sat)
; {cast-from-var484-to-var3099=([javax.servlet.ServletRequest], javax.servlet.http.HttpServletRequest), cast-from-var104-to-var636=([javax.servlet.ServletResponse], javax.servlet.http.HttpServletResponse), getProtocol/-383437256=([org.apache.dubbo.remoting.http12.HttpVersion], java.lang.String), var3099_getProtocol/-1459351703=([javax.servlet.http.HttpServletRequest], java.lang.String), mappingRegistry/-169562487=([org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter], org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry), var3099_getRequestURI/-1504339324=([javax.servlet.http.HttpServletRequest], java.lang.String), var3099_getMethod/-1074735744=([javax.servlet.http.HttpServletRequest], java.lang.String), var1286_exists/1670402595=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, java.lang.String, java.lang.String], boolean), cast-from-var3099-to-var484=([javax.servlet.http.HttpServletRequest], javax.servlet.ServletRequest), cast-from-var636-to-var104=([javax.servlet.http.HttpServletResponse], javax.servlet.ServletResponse), var1931_doFilter/1408701348=([javax.servlet.FilterChain, javax.servlet.ServletRequest, javax.servlet.ServletResponse], void)}
; {var3616=org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter, var505=r7, var484=javax.servlet.ServletRequest, var1761=r0, var104=javax.servlet.ServletResponse, var2501=r2, var1931=javax.servlet.FilterChain, var2671=r11, var3099=javax.servlet.http.HttpServletRequest, var582=r1, var636=javax.servlet.http.HttpServletResponse, var1166=r3, var1114=org.apache.dubbo.remoting.http12.HttpVersion, var1806=$r4, var2648=$r6, var2238=$r5, var3026=z0, var1286=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, var3189=$r8, var225=$r10, var417=$r9, var3095=$z1, var1202=$r15, var1728=$r16}
; {org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter=var3616, r7=var505, javax.servlet.ServletRequest=var484, r0=var1761, javax.servlet.ServletResponse=var104, r2=var2501, javax.servlet.FilterChain=var1931, r11=var2671, javax.servlet.http.HttpServletRequest=var3099, r1=var582, javax.servlet.http.HttpServletResponse=var636, r3=var1166, org.apache.dubbo.remoting.http12.HttpVersion=var1114, $r4=var1806, $r6=var2648, $r5=var2238, z0=var3026, org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry=var1286, $r8=var3189, $r10=var225, $r9=var417, $z1=var3095, $r15=var1202, $r16=var1728}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter;	r0 := @parameter0: javax.servlet.ServletRequest;	r2 := @parameter1: javax.servlet.ServletResponse;	r11 := @parameter2: javax.servlet.FilterChain;	r1 = (javax.servlet.http.HttpServletRequest) r0;	r3 = (javax.servlet.http.HttpServletResponse) r2;	$r4 = <org.apache.dubbo.remoting.http12.HttpVersion: org.apache.dubbo.remoting.http12.HttpVersion HTTP2>;	$r6 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.HttpVersion: java.lang.String getProtocol()>();	$r5 = interfaceinvoke r1.<javax.servlet.http.HttpServletRequest: java.lang.String getProtocol()>();	z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5);	if z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry>;	$r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry>;	$r10 = interfaceinvoke r1.<javax.servlet.http.HttpServletRequest: java.lang.String getRequestURI()>();	$r9 = interfaceinvoke r1.<javax.servlet.http.HttpServletRequest: java.lang.String getMethod()>();	$z1 = interfaceinvoke $r8.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: boolean exists(java.lang.String,java.lang.String)>($r10, $r9);	if $z1 == 0 goto $r15 = (javax.servlet.ServletRequest) r1;	$r15 = (javax.servlet.ServletRequest) r1;	$r16 = (javax.servlet.ServletResponse) r3;	interfaceinvoke r11.<javax.servlet.FilterChain: void doFilter(javax.servlet.ServletRequest,javax.servlet.ServletResponse)>($r15, $r16);	return
;block_num 3