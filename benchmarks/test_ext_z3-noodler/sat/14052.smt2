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

(declare-sort var1742 0)
(declare-sort var1778 0)
(declare-sort var101 0)
(declare-sort var1593 0)
(declare-sort var1807 0)
(declare-sort var3411 0)
(declare-sort var1731 0)
(declare-sort var2362 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var1778-to-var1807 (var1778) var1807)
(declare-fun cast-from-var101-to-var3411 (var101) var3411)
(declare-fun getProtocol/-383437256 (var1731) String)
(declare-fun var1807_getProtocol/-1538431987 (var1807) String)
(declare-fun mappingRegistry/430177669 (var1742) var2362)
(declare-fun var1807_getRequestURI/-191080920 (var1807) String)
(declare-fun var1807_getMethod/-904985820 (var1807) String)
(declare-fun var2362_exists/1670402595 (var2362 String String) Bool)
(declare-fun handleHttp1/2087016471 (var1742 var1807 var3411) void)
(declare-const null-var1742 var1742)
(declare-const null-var1778 var1778)
(declare-const null-var101 var101)
(declare-const null-var1593 var1593)
(declare-const var1731-HTTP2 var1731)
(declare-const var152 var1742) ; Statement: r7 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter 
(assert (not (= var152 null-var1742)))
(declare-const var3965 var1778) ; Statement: r0 := @parameter0: jakarta.servlet.ServletRequest 
(assert (not (= var3965 null-var1778)))
(declare-const var3120 var101) ; Statement: r2 := @parameter1: jakarta.servlet.ServletResponse 
(assert (not (= var3120 null-var101)))
(declare-const var177 var1593) ; Statement: r11 := @parameter2: jakarta.servlet.FilterChain 
(assert (not (= var177 null-var1593)))
(define-const var1150 var1807 (cast-from-var1778-to-var1807 var3965)) ; Statement: r1 = (jakarta.servlet.http.HttpServletRequest) r0 
(define-const var2841 var3411 (cast-from-var101-to-var3411 var3120)) ; Statement: r3 = (jakarta.servlet.http.HttpServletResponse) r2 
(define-const var682 var1731 var1731-HTTP2) ; Statement: $r4 = <org.apache.dubbo.remoting.http12.HttpVersion: org.apache.dubbo.remoting.http12.HttpVersion HTTP2> 
(assert true)
(define-const var1922 String (getProtocol/-383437256 var682)) ; Statement: $r6 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.HttpVersion: java.lang.String getProtocol()>() 
(define-const var476 String (var1807_getProtocol/-1538431987 var1150)) ; Statement: $r5 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getProtocol()>() 
(assert true)
(define-const var1325 Bool (= var1922 var476)) ; Statement: z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5) 
 ; Statement: if z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry> 
(assert (= (ite var1325 1 0) 0)) ; Cond: z0 == 0 
(define-const var3670 var2362 (mappingRegistry/430177669 var152)) ; Statement: $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry> 
(define-const var1426 String (var1807_getRequestURI/-191080920 var1150)) ; Statement: $r10 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getRequestURI()>() 
(define-const var864 String (var1807_getMethod/-904985820 var1150)) ; Statement: $r9 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getMethod()>() 
(define-const var1668 Bool (var2362_exists/1670402595 var3670 var1426 var864)) ; Statement: $z1 = interfaceinvoke $r8.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: boolean exists(java.lang.String,java.lang.String)>($r10, $r9) 
 ; Statement: if $z1 == 0 goto $r15 = (jakarta.servlet.ServletRequest) r1 
(assert (not (= (ite var1668 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
;(assert (handleHttp1/2087016471 var152 var1150 var2841)) ; Statement: specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: void handleHttp1(jakarta.servlet.http.HttpServletRequest,jakarta.servlet.http.HttpServletResponse)>(r1, r3) 

(declare-const var152!1 var1742)
(declare-const var1150!1 var1807)
(declare-const var2841!1 var3411)
 ; Statement: return 
(check-sat)
; {cast-from-var1778-to-var1807=([jakarta.servlet.ServletRequest], jakarta.servlet.http.HttpServletRequest), cast-from-var101-to-var3411=([jakarta.servlet.ServletResponse], jakarta.servlet.http.HttpServletResponse), getProtocol/-383437256=([org.apache.dubbo.remoting.http12.HttpVersion], java.lang.String), var1807_getProtocol/-1538431987=([jakarta.servlet.http.HttpServletRequest], java.lang.String), mappingRegistry/430177669=([org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter], org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry), var1807_getRequestURI/-191080920=([jakarta.servlet.http.HttpServletRequest], java.lang.String), var1807_getMethod/-904985820=([jakarta.servlet.http.HttpServletRequest], java.lang.String), var2362_exists/1670402595=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, java.lang.String, java.lang.String], boolean), handleHttp1/2087016471=([org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter, jakarta.servlet.http.HttpServletRequest, jakarta.servlet.http.HttpServletResponse], void)}
; {var1742=org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter, var152=r7, var1778=jakarta.servlet.ServletRequest, var3965=r0, var101=jakarta.servlet.ServletResponse, var3120=r2, var1593=jakarta.servlet.FilterChain, var177=r11, var1807=jakarta.servlet.http.HttpServletRequest, var1150=r1, var3411=jakarta.servlet.http.HttpServletResponse, var2841=r3, var1731=org.apache.dubbo.remoting.http12.HttpVersion, var682=$r4, var1922=$r6, var476=$r5, var1325=z0, var2362=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, var3670=$r8, var1426=$r10, var864=$r9, var1668=$z1}
; {org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter=var1742, r7=var152, jakarta.servlet.ServletRequest=var1778, r0=var3965, jakarta.servlet.ServletResponse=var101, r2=var3120, jakarta.servlet.FilterChain=var1593, r11=var177, jakarta.servlet.http.HttpServletRequest=var1807, r1=var1150, jakarta.servlet.http.HttpServletResponse=var3411, r3=var2841, org.apache.dubbo.remoting.http12.HttpVersion=var1731, $r4=var682, $r6=var1922, $r5=var476, z0=var1325, org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry=var2362, $r8=var3670, $r10=var1426, $r9=var864, $z1=var1668}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter;	r0 := @parameter0: jakarta.servlet.ServletRequest;	r2 := @parameter1: jakarta.servlet.ServletResponse;	r11 := @parameter2: jakarta.servlet.FilterChain;	r1 = (jakarta.servlet.http.HttpServletRequest) r0;	r3 = (jakarta.servlet.http.HttpServletResponse) r2;	$r4 = <org.apache.dubbo.remoting.http12.HttpVersion: org.apache.dubbo.remoting.http12.HttpVersion HTTP2>;	$r6 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.HttpVersion: java.lang.String getProtocol()>();	$r5 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getProtocol()>();	z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5);	if z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry>;	$r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry>;	$r10 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getRequestURI()>();	$r9 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getMethod()>();	$z1 = interfaceinvoke $r8.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: boolean exists(java.lang.String,java.lang.String)>($r10, $r9);	if $z1 == 0 goto $r15 = (jakarta.servlet.ServletRequest) r1;	specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: void handleHttp1(jakarta.servlet.http.HttpServletRequest,jakarta.servlet.http.HttpServletResponse)>(r1, r3);	return
;block_num 3