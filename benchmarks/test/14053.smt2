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

(declare-sort var3725 0)
(declare-sort var1304 0)
(declare-sort var3980 0)
(declare-sort var636 0)
(declare-sort var3572 0)
(declare-sort var2917 0)
(declare-sort var1852 0)
(declare-sort var2066 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var1304-to-var3572 (var1304) var3572)
(declare-fun cast-from-var3980-to-var2917 (var3980) var2917)
(declare-fun getProtocol/-383437256 (var1852) String)
(declare-fun var3572_getProtocol/-1538431987 (var3572) String)
(declare-fun mappingRegistry/430177669 (var3725) var2066)
(declare-fun var3572_getRequestURI/-191080920 (var3572) String)
(declare-fun var3572_getMethod/-904985820 (var3572) String)
(declare-fun var2066_exists/1670402595 (var2066 String String) Bool)
(declare-fun cast-from-var3572-to-var1304 (var3572) var1304)
(declare-fun cast-from-var2917-to-var3980 (var2917) var3980)
(declare-fun var636_doFilter/-1290422336 (var636 var1304 var3980) void)
(declare-const null-var3725 var3725)
(declare-const null-var1304 var1304)
(declare-const null-var3980 var3980)
(declare-const null-var636 var636)
(declare-const var1852-HTTP2 var1852)
(declare-const var2914 var3725) ; Statement: r7 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter 
(assert (not (= var2914 null-var3725)))
(declare-const var1689 var1304) ; Statement: r0 := @parameter0: jakarta.servlet.ServletRequest 
(assert (not (= var1689 null-var1304)))
(declare-const var2664 var3980) ; Statement: r2 := @parameter1: jakarta.servlet.ServletResponse 
(assert (not (= var2664 null-var3980)))
(declare-const var2206 var636) ; Statement: r11 := @parameter2: jakarta.servlet.FilterChain 
(assert (not (= var2206 null-var636)))
(define-const var358 var3572 (cast-from-var1304-to-var3572 var1689)) ; Statement: r1 = (jakarta.servlet.http.HttpServletRequest) r0 
(define-const var722 var2917 (cast-from-var3980-to-var2917 var2664)) ; Statement: r3 = (jakarta.servlet.http.HttpServletResponse) r2 
(define-const var2769 var1852 var1852-HTTP2) ; Statement: $r4 = <org.apache.dubbo.remoting.http12.HttpVersion: org.apache.dubbo.remoting.http12.HttpVersion HTTP2> 
(assert true)
(define-const var1672 String (getProtocol/-383437256 var2769)) ; Statement: $r6 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.HttpVersion: java.lang.String getProtocol()>() 
(define-const var3734 String (var3572_getProtocol/-1538431987 var358)) ; Statement: $r5 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getProtocol()>() 
(assert true)
(define-const var377 Bool (= var1672 var3734)) ; Statement: z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5) 
 ; Statement: if z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry> 
(assert (= (ite var377 1 0) 0)) ; Cond: z0 == 0 
(define-const var931 var2066 (mappingRegistry/430177669 var2914)) ; Statement: $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry> 
(define-const var273 String (var3572_getRequestURI/-191080920 var358)) ; Statement: $r10 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getRequestURI()>() 
(define-const var516 String (var3572_getMethod/-904985820 var358)) ; Statement: $r9 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getMethod()>() 
(define-const var1640 Bool (var2066_exists/1670402595 var931 var273 var516)) ; Statement: $z1 = interfaceinvoke $r8.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: boolean exists(java.lang.String,java.lang.String)>($r10, $r9) 
 ; Statement: if $z1 == 0 goto $r15 = (jakarta.servlet.ServletRequest) r1 
(assert (= (ite var1640 1 0) 0)) ; Cond: $z1 == 0 
(define-const var893 var1304 (cast-from-var3572-to-var1304 var358)) ; Statement: $r15 = (jakarta.servlet.ServletRequest) r1 
(define-const var2628 var3980 (cast-from-var2917-to-var3980 var722)) ; Statement: $r16 = (jakarta.servlet.ServletResponse) r3 
;(assert (var636_doFilter/-1290422336 var2206 var893 var2628)) ; Statement: interfaceinvoke r11.<jakarta.servlet.FilterChain: void doFilter(jakarta.servlet.ServletRequest,jakarta.servlet.ServletResponse)>($r15, $r16) 

(declare-const var2206!1 var636)
(declare-const var893!1 var1304)
(declare-const var2628!1 var3980)
 ; Statement: return 
(check-sat)
; {cast-from-var1304-to-var3572=([jakarta.servlet.ServletRequest], jakarta.servlet.http.HttpServletRequest), cast-from-var3980-to-var2917=([jakarta.servlet.ServletResponse], jakarta.servlet.http.HttpServletResponse), getProtocol/-383437256=([org.apache.dubbo.remoting.http12.HttpVersion], java.lang.String), var3572_getProtocol/-1538431987=([jakarta.servlet.http.HttpServletRequest], java.lang.String), mappingRegistry/430177669=([org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter], org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry), var3572_getRequestURI/-191080920=([jakarta.servlet.http.HttpServletRequest], java.lang.String), var3572_getMethod/-904985820=([jakarta.servlet.http.HttpServletRequest], java.lang.String), var2066_exists/1670402595=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, java.lang.String, java.lang.String], boolean), cast-from-var3572-to-var1304=([jakarta.servlet.http.HttpServletRequest], jakarta.servlet.ServletRequest), cast-from-var2917-to-var3980=([jakarta.servlet.http.HttpServletResponse], jakarta.servlet.ServletResponse), var636_doFilter/-1290422336=([jakarta.servlet.FilterChain, jakarta.servlet.ServletRequest, jakarta.servlet.ServletResponse], void)}
; {var3725=org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter, var2914=r7, var1304=jakarta.servlet.ServletRequest, var1689=r0, var3980=jakarta.servlet.ServletResponse, var2664=r2, var636=jakarta.servlet.FilterChain, var2206=r11, var3572=jakarta.servlet.http.HttpServletRequest, var358=r1, var2917=jakarta.servlet.http.HttpServletResponse, var722=r3, var1852=org.apache.dubbo.remoting.http12.HttpVersion, var2769=$r4, var1672=$r6, var3734=$r5, var377=z0, var2066=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, var931=$r8, var273=$r10, var516=$r9, var1640=$z1, var893=$r15, var2628=$r16}
; {org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter=var3725, r7=var2914, jakarta.servlet.ServletRequest=var1304, r0=var1689, jakarta.servlet.ServletResponse=var3980, r2=var2664, jakarta.servlet.FilterChain=var636, r11=var2206, jakarta.servlet.http.HttpServletRequest=var3572, r1=var358, jakarta.servlet.http.HttpServletResponse=var2917, r3=var722, org.apache.dubbo.remoting.http12.HttpVersion=var1852, $r4=var2769, $r6=var1672, $r5=var3734, z0=var377, org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry=var2066, $r8=var931, $r10=var273, $r9=var516, $z1=var1640, $r15=var893, $r16=var2628}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter;	r0 := @parameter0: jakarta.servlet.ServletRequest;	r2 := @parameter1: jakarta.servlet.ServletResponse;	r11 := @parameter2: jakarta.servlet.FilterChain;	r1 = (jakarta.servlet.http.HttpServletRequest) r0;	r3 = (jakarta.servlet.http.HttpServletResponse) r2;	$r4 = <org.apache.dubbo.remoting.http12.HttpVersion: org.apache.dubbo.remoting.http12.HttpVersion HTTP2>;	$r6 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.HttpVersion: java.lang.String getProtocol()>();	$r5 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getProtocol()>();	z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5);	if z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry>;	$r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry>;	$r10 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getRequestURI()>();	$r9 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getMethod()>();	$z1 = interfaceinvoke $r8.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry: boolean exists(java.lang.String,java.lang.String)>($r10, $r9);	if $z1 == 0 goto $r15 = (jakarta.servlet.ServletRequest) r1;	$r15 = (jakarta.servlet.ServletRequest) r1;	$r16 = (jakarta.servlet.ServletResponse) r3;	interfaceinvoke r11.<jakarta.servlet.FilterChain: void doFilter(jakarta.servlet.ServletRequest,jakarta.servlet.ServletResponse)>($r15, $r16);	return
;block_num 3