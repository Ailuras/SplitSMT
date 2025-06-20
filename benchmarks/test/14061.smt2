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

(declare-sort var2613 0)
(declare-sort var1335 0)
(declare-sort var3607 0)
(declare-sort var2254 0)
(declare-sort var3458 0)
(declare-sort var2587 0)
(declare-sort var3056 0)
(declare-sort var3967 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var1335-to-var3458 (var1335) var3458)
(declare-fun cast-from-var3607-to-var2587 (var3607) var2587)
(declare-fun getProtocol/-383437256 (var3056) String)
(declare-fun var3458_getProtocol/-1538431987 (var3458) String)
(declare-fun hasGrpcMapping/1209514133 (var2613 var3458) Bool)
(declare-fun mappingRegistry/430177669 (var2613) var3967)
(declare-fun var3458_getRequestURI/-191080920 (var3458) String)
(declare-fun var3458_getMethod/-904985820 (var3458) String)
(declare-fun var3967_exists/1670402595 (var3967 String String) Bool)
(declare-fun cast-from-var3458-to-var1335 (var3458) var1335)
(declare-fun cast-from-var2587-to-var3607 (var2587) var3607)
(declare-fun var2254_doFilter/-1290422336 (var2254 var1335 var3607) void)
(declare-const null-var2613 var2613)
(declare-const null-var1335 var1335)
(declare-const null-var3607 var3607)
(declare-const null-var2254 var2254)
(declare-const var3056-HTTP2 var3056)
(declare-const var3701 var2613) ; Statement: r7 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter 
(assert (not (= var3701 null-var2613)))
(declare-const var1685 var1335) ; Statement: r0 := @parameter0: jakarta.servlet.ServletRequest 
(assert (not (= var1685 null-var1335)))
(declare-const var1371 var3607) ; Statement: r2 := @parameter1: jakarta.servlet.ServletResponse 
(assert (not (= var1371 null-var3607)))
(declare-const var3391 var2254) ; Statement: r11 := @parameter2: jakarta.servlet.FilterChain 
(assert (not (= var3391 null-var2254)))
(define-const var764 var3458 (cast-from-var1335-to-var3458 var1685)) ; Statement: r1 = (jakarta.servlet.http.HttpServletRequest) r0 
(define-const var1767 var2587 (cast-from-var3607-to-var2587 var1371)) ; Statement: r3 = (jakarta.servlet.http.HttpServletResponse) r2 
(define-const var2029 var3056 var3056-HTTP2) ; Statement: $r4 = <org.apache.dubbo.remoting.http12.HttpVersion: org.apache.dubbo.remoting.http12.HttpVersion HTTP2> 
(assert true)
(define-const var3207 String (getProtocol/-383437256 var2029)) ; Statement: $r6 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.HttpVersion: java.lang.String getProtocol()>() 
(define-const var491 String (var3458_getProtocol/-1538431987 var764)) ; Statement: $r5 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getProtocol()>() 
(assert true)
(define-const var3150 Bool (= var3207 var491)) ; Statement: z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5) 
 ; Statement: if z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry> 
(assert (not (= (ite var3150 1 0) 0))) ; Negate: Cond: z0 == 0  
(assert true)
(define-const var1321 Bool (hasGrpcMapping/1209514133 var3701 var764)) ; Statement: $z2 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: boolean hasGrpcMapping(jakarta.servlet.http.HttpServletRequest)>(r1) 
 ; Statement: if $z2 != 0 goto specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: void handleHttp2(jakarta.servlet.http.HttpServletRequest,jakarta.servlet.http.HttpServletResponse)>(r1, r3) 
(assert (not (not (= (ite var1321 1 0) 0)))) ; Negate: Cond: $z2 != 0  
(define-const var225 var3967 (mappingRegistry/430177669 var3701)) ; Statement: $r12 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry> 
(define-const var32 String (var3458_getRequestURI/-191080920 var764)) ; Statement: $r14 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getRequestURI()>() 
(define-const var1208 String (var3458_getMethod/-904985820 var764)) ; Statement: $r13 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getMethod()>() 
(define-const var2678 Bool (var3967_exists/1670402595 var225 var32 var1208)) ; Statement: $z3 = interfaceinvoke $r12.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: boolean exists(java.lang.String,java.lang.String)>($r14, $r13) 
 ; Statement: if $z3 == 0 goto $r15 = (jakarta.servlet.ServletRequest) r1 
(assert (= (ite var2678 1 0) 0)) ; Cond: $z3 == 0 
(define-const var1266 var1335 (cast-from-var3458-to-var1335 var764)) ; Statement: $r15 = (jakarta.servlet.ServletRequest) r1 
(define-const var1442 var3607 (cast-from-var2587-to-var3607 var1767)) ; Statement: $r16 = (jakarta.servlet.ServletResponse) r3 
;(assert (var2254_doFilter/-1290422336 var3391 var1266 var1442)) ; Statement: interfaceinvoke r11.<jakarta.servlet.FilterChain: void doFilter(jakarta.servlet.ServletRequest,jakarta.servlet.ServletResponse)>($r15, $r16) 

(declare-const var3391!1 var2254)
(declare-const var1266!1 var1335)
(declare-const var1442!1 var3607)
 ; Statement: return 
(check-sat)
; {cast-from-var1335-to-var3458=([jakarta.servlet.ServletRequest], jakarta.servlet.http.HttpServletRequest), cast-from-var3607-to-var2587=([jakarta.servlet.ServletResponse], jakarta.servlet.http.HttpServletResponse), getProtocol/-383437256=([org.apache.dubbo.remoting.http12.HttpVersion], java.lang.String), var3458_getProtocol/-1538431987=([jakarta.servlet.http.HttpServletRequest], java.lang.String), hasGrpcMapping/1209514133=([org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter, jakarta.servlet.http.HttpServletRequest], boolean), mappingRegistry/430177669=([org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter], org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry), var3458_getRequestURI/-191080920=([jakarta.servlet.http.HttpServletRequest], java.lang.String), var3458_getMethod/-904985820=([jakarta.servlet.http.HttpServletRequest], java.lang.String), var3967_exists/1670402595=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, java.lang.String, java.lang.String], boolean), cast-from-var3458-to-var1335=([jakarta.servlet.http.HttpServletRequest], jakarta.servlet.ServletRequest), cast-from-var2587-to-var3607=([jakarta.servlet.http.HttpServletResponse], jakarta.servlet.ServletResponse), var2254_doFilter/-1290422336=([jakarta.servlet.FilterChain, jakarta.servlet.ServletRequest, jakarta.servlet.ServletResponse], void)}
; {var2613=org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter, var3701=r7, var1335=jakarta.servlet.ServletRequest, var1685=r0, var3607=jakarta.servlet.ServletResponse, var1371=r2, var2254=jakarta.servlet.FilterChain, var3391=r11, var3458=jakarta.servlet.http.HttpServletRequest, var764=r1, var2587=jakarta.servlet.http.HttpServletResponse, var1767=r3, var3056=org.apache.dubbo.remoting.http12.HttpVersion, var2029=$r4, var3207=$r6, var491=$r5, var3150=z0, var1321=$z2, var3967=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, var225=$r12, var32=$r14, var1208=$r13, var2678=$z3, var1266=$r15, var1442=$r16}
; {org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter=var2613, r7=var3701, jakarta.servlet.ServletRequest=var1335, r0=var1685, jakarta.servlet.ServletResponse=var3607, r2=var1371, jakarta.servlet.FilterChain=var2254, r11=var3391, jakarta.servlet.http.HttpServletRequest=var3458, r1=var764, jakarta.servlet.http.HttpServletResponse=var2587, r3=var1767, org.apache.dubbo.remoting.http12.HttpVersion=var3056, $r4=var2029, $r6=var3207, $r5=var491, z0=var3150, $z2=var1321, org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry=var3967, $r12=var225, $r14=var32, $r13=var1208, $z3=var2678, $r15=var1266, $r16=var1442}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter;	r0 := @parameter0: jakarta.servlet.ServletRequest;	r2 := @parameter1: jakarta.servlet.ServletResponse;	r11 := @parameter2: jakarta.servlet.FilterChain;	r1 = (jakarta.servlet.http.HttpServletRequest) r0;	r3 = (jakarta.servlet.http.HttpServletResponse) r2;	$r4 = <org.apache.dubbo.remoting.http12.HttpVersion: org.apache.dubbo.remoting.http12.HttpVersion HTTP2>;	$r6 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.HttpVersion: java.lang.String getProtocol()>();	$r5 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getProtocol()>();	z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5);	if z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry>;	$z2 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: boolean hasGrpcMapping(jakarta.servlet.http.HttpServletRequest)>(r1);	if $z2 != 0 goto specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: void handleHttp2(jakarta.servlet.http.HttpServletRequest,jakarta.servlet.http.HttpServletResponse)>(r1, r3);	$r12 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry>;	$r14 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getRequestURI()>();	$r13 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getMethod()>();	$z3 = interfaceinvoke $r12.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: boolean exists(java.lang.String,java.lang.String)>($r14, $r13);	if $z3 == 0 goto $r15 = (jakarta.servlet.ServletRequest) r1;	$r15 = (jakarta.servlet.ServletRequest) r1;	$r16 = (jakarta.servlet.ServletResponse) r3;	interfaceinvoke r11.<jakarta.servlet.FilterChain: void doFilter(jakarta.servlet.ServletRequest,jakarta.servlet.ServletResponse)>($r15, $r16);	return
;block_num 4