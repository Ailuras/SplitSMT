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

(declare-sort var10 0)
(declare-sort var922 0)
(declare-sort var2941 0)
(declare-sort var3665 0)
(declare-sort var1768 0)
(declare-sort var539 0)
(declare-sort var3184 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var922-to-var1768 (var922) var1768)
(declare-fun cast-from-var2941-to-var539 (var2941) var539)
(declare-fun getProtocol/-383437256 (var3184) String)
(declare-fun var1768_getProtocol/-1459351703 (var1768) String)
(declare-fun hasGrpcMapping/1732092925 (var10 var1768) Bool)
(declare-fun handleHttp2/-347666582 (var10 var1768 var539) void)
(declare-const null-var10 var10)
(declare-const null-var922 var922)
(declare-const null-var2941 var2941)
(declare-const null-var3665 var3665)
(declare-const var3184-HTTP2 var3184)
(declare-const var2792 var10) ; Statement: r7 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter 
(assert (not (= var2792 null-var10)))
(declare-const var2171 var922) ; Statement: r0 := @parameter0: javax.servlet.ServletRequest 
(assert (not (= var2171 null-var922)))
(declare-const var2427 var2941) ; Statement: r2 := @parameter1: javax.servlet.ServletResponse 
(assert (not (= var2427 null-var2941)))
(declare-const var2572 var3665) ; Statement: r11 := @parameter2: javax.servlet.FilterChain 
(assert (not (= var2572 null-var3665)))
(define-const var1815 var1768 (cast-from-var922-to-var1768 var2171)) ; Statement: r1 = (javax.servlet.http.HttpServletRequest) r0 
(define-const var2562 var539 (cast-from-var2941-to-var539 var2427)) ; Statement: r3 = (javax.servlet.http.HttpServletResponse) r2 
(define-const var1050 var3184 var3184-HTTP2) ; Statement: $r4 = <org.apache.dubbo.remoting.http12.HttpVersion: org.apache.dubbo.remoting.http12.HttpVersion HTTP2> 
(assert true)
(define-const var178 String (getProtocol/-383437256 var1050)) ; Statement: $r6 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.HttpVersion: java.lang.String getProtocol()>() 
(define-const var1212 String (var1768_getProtocol/-1459351703 var1815)) ; Statement: $r5 = interfaceinvoke r1.<javax.servlet.http.HttpServletRequest: java.lang.String getProtocol()>() 
(assert true)
(define-const var1221 Bool (= var178 var1212)) ; Statement: z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5) 
 ; Statement: if z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry> 
(assert (not (= (ite var1221 1 0) 0))) ; Negate: Cond: z0 == 0  
(assert true)
(define-const var327 Bool (hasGrpcMapping/1732092925 var2792 var1815)) ; Statement: $z2 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: boolean hasGrpcMapping(javax.servlet.http.HttpServletRequest)>(r1) 
 ; Statement: if $z2 != 0 goto specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: void handleHttp2(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse)>(r1, r3) 
(assert (not (= (ite var327 1 0) 0))) ; Cond: $z2 != 0 
(assert true)
;(assert (handleHttp2/-347666582 var2792 var1815 var2562)) ; Statement: specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: void handleHttp2(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse)>(r1, r3) 

(declare-const var2792!1 var10)
(declare-const var1815!1 var1768)
(declare-const var2562!1 var539)
 ; Statement: return 
(check-sat)
; {cast-from-var922-to-var1768=([javax.servlet.ServletRequest], javax.servlet.http.HttpServletRequest), cast-from-var2941-to-var539=([javax.servlet.ServletResponse], javax.servlet.http.HttpServletResponse), getProtocol/-383437256=([org.apache.dubbo.remoting.http12.HttpVersion], java.lang.String), var1768_getProtocol/-1459351703=([javax.servlet.http.HttpServletRequest], java.lang.String), hasGrpcMapping/1732092925=([org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter, javax.servlet.http.HttpServletRequest], boolean), handleHttp2/-347666582=([org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse], void)}
; {var10=org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter, var2792=r7, var922=javax.servlet.ServletRequest, var2171=r0, var2941=javax.servlet.ServletResponse, var2427=r2, var3665=javax.servlet.FilterChain, var2572=r11, var1768=javax.servlet.http.HttpServletRequest, var1815=r1, var539=javax.servlet.http.HttpServletResponse, var2562=r3, var3184=org.apache.dubbo.remoting.http12.HttpVersion, var1050=$r4, var178=$r6, var1212=$r5, var1221=z0, var327=$z2}
; {org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter=var10, r7=var2792, javax.servlet.ServletRequest=var922, r0=var2171, javax.servlet.ServletResponse=var2941, r2=var2427, javax.servlet.FilterChain=var3665, r11=var2572, javax.servlet.http.HttpServletRequest=var1768, r1=var1815, javax.servlet.http.HttpServletResponse=var539, r3=var2562, org.apache.dubbo.remoting.http12.HttpVersion=var3184, $r4=var1050, $r6=var178, $r5=var1212, z0=var1221, $z2=var327}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter;	r0 := @parameter0: javax.servlet.ServletRequest;	r2 := @parameter1: javax.servlet.ServletResponse;	r11 := @parameter2: javax.servlet.FilterChain;	r1 = (javax.servlet.http.HttpServletRequest) r0;	r3 = (javax.servlet.http.HttpServletResponse) r2;	$r4 = <org.apache.dubbo.remoting.http12.HttpVersion: org.apache.dubbo.remoting.http12.HttpVersion HTTP2>;	$r6 = virtualinvoke $r4.<org.apache.dubbo.remoting.http12.HttpVersion: java.lang.String getProtocol()>();	$r5 = interfaceinvoke r1.<javax.servlet.http.HttpServletRequest: java.lang.String getProtocol()>();	z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5);	if z0 == 0 goto $r8 = r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry>;	$z2 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: boolean hasGrpcMapping(javax.servlet.http.HttpServletRequest)>(r1);	if $z2 != 0 goto specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: void handleHttp2(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse)>(r1, r3);	specialinvoke r7.<org.apache.dubbo.rpc.protocol.tri.servlet.TripleFilter: void handleHttp2(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse)>(r1, r3);	return
;block_num 3