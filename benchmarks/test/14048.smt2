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

(declare-sort var210 0)
(declare-sort var2653 0)
(declare-sort var3115 0)
(declare-sort var2448 0)
(declare-sort var730 0)
(declare-sort var2534 0)
(declare-sort var3703 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var2653-to-var730 (var2653) var730)
(declare-fun cast-from-var3115-to-var2534 (var3115) var2534)
(declare-fun getProtocol/-383437256 (var3703) String)
(declare-fun var730_getProtocol/-1538431987 (var730) String)
(declare-fun hasGrpcMapping/1209514133 (var210 var730) Bool)
(declare-fun handleHttp2/-1000032650 (var210 var730 var2534) void)
(declare-const null-var210 var210)
(declare-const null-var2653 var2653)
(declare-const null-var3115 var3115)
(declare-const null-var2448 var2448)
(declare-const var3703-HTTP2 var3703)
(declare-const var660 var210) ; Statement: r7 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter 
(assert (not (= var660 null-var210)))
(declare-const var1453 var2653) ; Statement: r0 := @parameter0: jakarta.servlet.ServletRequest 
(assert (not (= var1453 null-var2653)))
(declare-const var1757 var3115) ; Statement: r2 := @parameter1: jakarta.servlet.ServletResponse 
(assert (not (= var1757 null-var3115)))
(declare-const var1740 var2448) ; Statement: r11 := @parameter2: jakarta.servlet.FilterChain 
(assert (not (= var1740 null-var2448)))
(define-const var685 var730 (cast-from-var2653-to-var730 var1453)) ; Statement: r1 = (jakarta.servlet.http.HttpServletRequest) r0 
(define-const var1042 var2534 (cast-from-var3115-to-var2534 var1757)) ; Statement: r3 = (jakarta.servlet.http.HttpServletResponse) r2 
(define-const var1490 var3703 var3703-HTTP2) ; Statement: $r4 = <org.apache.dubbo.remoting.http12.HttpVersion: org.apache.dubbo.remoting.http12.HttpVersion HTTP2> 
(assert true)
(define-const var2207 String (getProtocol/-383437256 var1490)) ; Statement: $r6 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.HttpVersion: java.lang.String getProtocol()>() 
(define-const var3763 String (var730_getProtocol/-1538431987 var685)) ; Statement: $r5 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getProtocol()>() 
(assert true)
(define-const var1332 Bool (= var2207 var3763)) ; Statement: z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5) 
 ; Statement: if z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry> 
(assert (not (= (ite var1332 1 0) 0))) ; Negate: Cond: z0 == 0  
(assert true)
(define-const var1228 Bool (hasGrpcMapping/1209514133 var660 var685)) ; Statement: $z2 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: boolean hasGrpcMapping(jakarta.servlet.http.HttpServletRequest)>(r1) 
 ; Statement: if $z2 != 0 goto specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: void handleHttp2(jakarta.servlet.http.HttpServletRequest,jakarta.servlet.http.HttpServletResponse)>(r1, r3) 
(assert (not (= (ite var1228 1 0) 0))) ; Cond: $z2 != 0 
(assert true)
;(assert (handleHttp2/-1000032650 var660 var685 var1042)) ; Statement: specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: void handleHttp2(jakarta.servlet.http.HttpServletRequest,jakarta.servlet.http.HttpServletResponse)>(r1, r3) 

(declare-const var660!1 var210)
(declare-const var685!1 var730)
(declare-const var1042!1 var2534)
 ; Statement: return 
(check-sat)
; {cast-from-var2653-to-var730=([jakarta.servlet.ServletRequest], jakarta.servlet.http.HttpServletRequest), cast-from-var3115-to-var2534=([jakarta.servlet.ServletResponse], jakarta.servlet.http.HttpServletResponse), getProtocol/-383437256=([org.apache.dubbo.remoting.http12.HttpVersion], java.lang.String), var730_getProtocol/-1538431987=([jakarta.servlet.http.HttpServletRequest], java.lang.String), hasGrpcMapping/1209514133=([org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter, jakarta.servlet.http.HttpServletRequest], boolean), handleHttp2/-1000032650=([org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter, jakarta.servlet.http.HttpServletRequest, jakarta.servlet.http.HttpServletResponse], void)}
; {var210=org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter, var660=r7, var2653=jakarta.servlet.ServletRequest, var1453=r0, var3115=jakarta.servlet.ServletResponse, var1757=r2, var2448=jakarta.servlet.FilterChain, var1740=r11, var730=jakarta.servlet.http.HttpServletRequest, var685=r1, var2534=jakarta.servlet.http.HttpServletResponse, var1042=r3, var3703=org.apache.dubbo.remoting.http12.HttpVersion, var1490=$r4, var2207=$r6, var3763=$r5, var1332=z0, var1228=$z2}
; {org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter=var210, r7=var660, jakarta.servlet.ServletRequest=var2653, r0=var1453, jakarta.servlet.ServletResponse=var3115, r2=var1757, jakarta.servlet.FilterChain=var2448, r11=var1740, jakarta.servlet.http.HttpServletRequest=var730, r1=var685, jakarta.servlet.http.HttpServletResponse=var2534, r3=var1042, org.apache.dubbo.remoting.http12.HttpVersion=var3703, $r4=var1490, $r6=var2207, $r5=var3763, z0=var1332, $z2=var1228}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter;	r0 := @parameter0: jakarta.servlet.ServletRequest;	r2 := @parameter1: jakarta.servlet.ServletResponse;	r11 := @parameter2: jakarta.servlet.FilterChain;	r1 = (jakarta.servlet.http.HttpServletRequest) r0;	r3 = (jakarta.servlet.http.HttpServletResponse) r2;	$r4 = <org.apache.dubbo.remoting.http12.HttpVersion: org.apache.dubbo.remoting.http12.HttpVersion HTTP2>;	$r6 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.HttpVersion: java.lang.String getProtocol()>();	$r5 = interfaceinvoke r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getProtocol()>();	z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5);	if z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry>;	$z2 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: boolean hasGrpcMapping(jakarta.servlet.http.HttpServletRequest)>(r1);	if $z2 != 0 goto specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: void handleHttp2(jakarta.servlet.http.HttpServletRequest,jakarta.servlet.http.HttpServletResponse)>(r1, r3);	specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.TripleFilter: void handleHttp2(jakarta.servlet.http.HttpServletRequest,jakarta.servlet.http.HttpServletResponse)>(r1, r3);	return
;block_num 3