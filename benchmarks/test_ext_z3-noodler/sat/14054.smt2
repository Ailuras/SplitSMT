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

(declare-sort var3609 0)
(declare-sort var1078 0)
(declare-sort var2963 0)
(declare-sort var1762 0)
(declare-sort var3550 0)
(declare-sort var2626 0)
(declare-sort var3919 0)
(declare-sort var424 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var1078-to-var3550 (var1078) var3550)
(declare-fun cast-from-var2963-to-var2626 (var2963) var2626)
(declare-fun getProtocol/-383437256 (var3919) String)
(declare-fun var3550_getProtocol/-1538431987 (var3550) String)
(declare-fun hasGrpcMapping/1209514133 (var3609 var3550) Bool)
(declare-fun mappingRegistry/430177669 (var3609) var424)
(declare-fun var3550_getRequestURI/-191080920 (var3550) String)
(declare-fun var3550_getMethod/-904985820 (var3550) String)
(declare-fun var424_exists/1670402595 (var424 String String) Bool)
(declare-fun handleHttp2/-1000032650 (var3609 var3550 var2626) void)
(declare-const null-var3609 var3609)
(declare-const null-var1078 var1078)
(declare-const null-var2963 var2963)
(declare-const null-var1762 var1762)
(declare-const var3919-HTTP2 var3919)
(declare-const var1733 var3609) ; Statement: r7 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter 
(assert (not (= var1733 null-var3609)))
(declare-const var3189 var1078) ; Statement: r0 := @parameter0: jakarta.servlet.ServletRequest 
(assert (not (= var3189 null-var1078)))
(declare-const var191 var2963) ; Statement: r2 := @parameter1: jakarta.servlet.ServletResponse 
(assert (not (= var191 null-var2963)))
(declare-const var3430 var1762) ; Statement: r11 := @parameter2: jakarta.servlet.FilterChain 
(assert (not (= var3430 null-var1762)))
(define-const var3902 var3550 (cast-from-var1078-to-var3550 var3189)) ; Statement: r1 = (jakarta.servlet.http.HttpServletRequest) r0 
(define-const var1357 var2626 (cast-from-var2963-to-var2626 var191)) ; Statement: r3 = (jakarta.servlet.http.HttpServletResponse) r2 
(define-const var3751 var3919 var3919-HTTP2) ; Statement: $r4 = <org.apache.dubbo.remoting.http12.HttpVersion: org.apache.dubbo.remoting.http12.HttpVersion HTTP2> 
(assert true)
(define-const var1748 String (getProtocol/-383437256 var3751)) ; Statement: $r6 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.HttpVersion: java.lang.String getProtocol()>() 
(define-const var1092 String (var3550_getProtocol/-1538431987 var3902)) ; Statement: $r5 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getProtocol()>() 
(assert true)
(define-const var1605 Bool (= var1748 var1092)) ; Statement: z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5) 
 ; Statement: if z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry> 
(assert (not (= (ite var1605 1 0) 0))) ; Negate: Cond: z0 == 0  
(assert true)
(define-const var387 Bool (hasGrpcMapping/1209514133 var1733 var3902)) ; Statement: $z2 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: boolean hasGrpcMapping(jakarta.servlet.http.HttpServletRequest)>(r1) 
 ; Statement: if $z2 != 0 goto specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: void handleHttp2(jakarta.servlet.http.HttpServletRequest,jakarta.servlet.http.HttpServletResponse)>(r1, r3) 
(assert (not (not (= (ite var387 1 0) 0)))) ; Negate: Cond: $z2 != 0  
(define-const var777 var424 (mappingRegistry/430177669 var1733)) ; Statement: $r12 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry> 
(define-const var2256 String (var3550_getRequestURI/-191080920 var3902)) ; Statement: $r14 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getRequestURI()>() 
(define-const var3669 String (var3550_getMethod/-904985820 var3902)) ; Statement: $r13 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getMethod()>() 
(define-const var3773 Bool (var424_exists/1670402595 var777 var2256 var3669)) ; Statement: $z3 = interfaceinvoke $r12.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: boolean exists(java.lang.String,java.lang.String)>($r14, $r13) 
 ; Statement: if $z3 == 0 goto $r15 = (jakarta.servlet.ServletRequest) r1 
(assert (not (= (ite var3773 1 0) 0))) ; Negate: Cond: $z3 == 0  
(assert true)
;(assert (handleHttp2/-1000032650 var1733 var3902 var1357)) ; Statement: specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: void handleHttp2(jakarta.servlet.http.HttpServletRequest,jakarta.servlet.http.HttpServletResponse)>(r1, r3) 

(declare-const var1733!1 var3609)
(declare-const var3902!1 var3550)
(declare-const var1357!1 var2626)
 ; Statement: return 
(check-sat)
; {cast-from-var1078-to-var3550=([jakarta.servlet.ServletRequest], jakarta.servlet.http.HttpServletRequest), cast-from-var2963-to-var2626=([jakarta.servlet.ServletResponse], jakarta.servlet.http.HttpServletResponse), getProtocol/-383437256=([org.apache.dubbo.remoting.http12.HttpVersion], java.lang.String), var3550_getProtocol/-1538431987=([jakarta.servlet.http.HttpServletRequest], java.lang.String), hasGrpcMapping/1209514133=([org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter, jakarta.servlet.http.HttpServletRequest], boolean), mappingRegistry/430177669=([org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter], org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry), var3550_getRequestURI/-191080920=([jakarta.servlet.http.HttpServletRequest], java.lang.String), var3550_getMethod/-904985820=([jakarta.servlet.http.HttpServletRequest], java.lang.String), var424_exists/1670402595=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, java.lang.String, java.lang.String], boolean), handleHttp2/-1000032650=([org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter, jakarta.servlet.http.HttpServletRequest, jakarta.servlet.http.HttpServletResponse], void)}
; {var3609=org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter, var1733=r7, var1078=jakarta.servlet.ServletRequest, var3189=r0, var2963=jakarta.servlet.ServletResponse, var191=r2, var1762=jakarta.servlet.FilterChain, var3430=r11, var3550=jakarta.servlet.http.HttpServletRequest, var3902=r1, var2626=jakarta.servlet.http.HttpServletResponse, var1357=r3, var3919=org.apache.dubbo.remoting.http12.HttpVersion, var3751=$r4, var1748=$r6, var1092=$r5, var1605=z0, var387=$z2, var424=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, var777=$r12, var2256=$r14, var3669=$r13, var3773=$z3}
; {org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter=var3609, r7=var1733, jakarta.servlet.ServletRequest=var1078, r0=var3189, jakarta.servlet.ServletResponse=var2963, r2=var191, jakarta.servlet.FilterChain=var1762, r11=var3430, jakarta.servlet.http.HttpServletRequest=var3550, r1=var3902, jakarta.servlet.http.HttpServletResponse=var2626, r3=var1357, org.apache.dubbo.remoting.http12.HttpVersion=var3919, $r4=var3751, $r6=var1748, $r5=var1092, z0=var1605, $z2=var387, org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry=var424, $r12=var777, $r14=var2256, $r13=var3669, $z3=var3773}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter;	r0 := @parameter0: jakarta.servlet.ServletRequest;	r2 := @parameter1: jakarta.servlet.ServletResponse;	r11 := @parameter2: jakarta.servlet.FilterChain;	r1 = (jakarta.servlet.http.HttpServletRequest) r0;	r3 = (jakarta.servlet.http.HttpServletResponse) r2;	$r4 = <org.apache.dubbo.remoting.http12.HttpVersion: org.apache.dubbo.remoting.http12.HttpVersion HTTP2>;	$r6 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.HttpVersion: java.lang.String getProtocol()>();	$r5 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getProtocol()>();	z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5);	if z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry>;	$z2 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: boolean hasGrpcMapping(jakarta.servlet.http.HttpServletRequest)>(r1);	if $z2 != 0 goto specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: void handleHttp2(jakarta.servlet.http.HttpServletRequest,jakarta.servlet.http.HttpServletResponse)>(r1, r3);	$r12 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry>;	$r14 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getRequestURI()>();	$r13 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getMethod()>();	$z3 = interfaceinvoke $r12.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: boolean exists(java.lang.String,java.lang.String)>($r14, $r13);	if $z3 == 0 goto $r15 = (jakarta.servlet.ServletRequest) r1;	specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: void handleHttp2(jakarta.servlet.http.HttpServletRequest,jakarta.servlet.http.HttpServletResponse)>(r1, r3);	return
;block_num 4