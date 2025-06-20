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

(declare-sort var2208 0)
(declare-sort var3399 0)
(declare-sort var1083 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun request/323769481 (var2208) var3399)
(declare-fun var3399_getQueryString/1055414908 (var3399) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var3399_getRequestURI/-191080920 (var3399) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2208 var2208)
(declare-const null-String String)
(declare-const var2137 var2208) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.HttpMetadataAdapter 
(assert (not (= var2137 null-var2208)))
(define-const var3419 var3399 (request/323769481 var2137)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.HttpMetadataAdapter: jakarta.servlet.http.HttpServletRequest request> 
(define-const var3441 String (var3399_getQueryString/1055414908 var3419)) ; Statement: r2 = interfaceinvoke $r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getQueryString()>() 
 ; Statement: if r2 != null goto $r3 = new java.lang.StringBuilder 
(assert (not (= var3441 null-String))) ; Cond: r2 != null 
(define-const var1229 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1229)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1229!1 String)
(assert (= var1229!1 ""))
(define-const var1430 var3399 (request/323769481 var2137)) ; Statement: $r4 = r0.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.HttpMetadataAdapter: jakarta.servlet.http.HttpServletRequest request> 
(define-const var425 String (var3399_getRequestURI/-191080920 var1430)) ; Statement: $r5 = interfaceinvoke $r4.<jakarta.servlet.http.HttpServletRequest: java.lang.String getRequestURI()>() 
(assert true)
(define-const var2667 String (append/672562846 var1229!1 var425)) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var1229!2 String)
(assert (= var1229!2 (str.++ var1229!1 var425)))
(assert true)
(define-const var792 String (append/-1166366385 var2667 63)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(63) 
(declare-const var2667!1 String)
(assert (str.prefixof var2667 var2667!1))
(assert true)
(define-const var887 String (append/672562846 var792 var3441)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var792!1 String)
(assert (= var792!1 (str.++ var792 var3441)))
(assert true)
(define-const var184 String (toString/-2075883882 var887)) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
 ; Statement: return $r10 
(check-sat)
; {request/323769481=([org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.HttpMetadataAdapter], jakarta.servlet.http.HttpServletRequest), var3399_getQueryString/1055414908=([jakarta.servlet.http.HttpServletRequest], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var3399_getRequestURI/-191080920=([jakarta.servlet.http.HttpServletRequest], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2208=org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.HttpMetadataAdapter, var2137=r0, var3399=jakarta.servlet.http.HttpServletRequest, var3419=$r1, var3441=r2, var1083=null_type, var1229=$r3, var1430=$r4, var425=$r5, var2667=$r6, var792=$r7, var887=$r8, var184=$r10}
; {org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.HttpMetadataAdapter=var2208, r0=var2137, jakarta.servlet.http.HttpServletRequest=var3399, $r1=var3419, r2=var3441, null_type=var1083, $r3=var1229, $r4=var1430, $r5=var425, $r6=var2667, $r7=var792, $r8=var887, $r10=var184}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.HttpMetadataAdapter;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.HttpMetadataAdapter: jakarta.servlet.http.HttpServletRequest request>;	r2 = interfaceinvoke $r1.<jakarta.servlet.http.HttpServletRequest: java.lang.String getQueryString()>();	if r2 != null goto $r3 = new java.lang.StringBuilder;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = r0.<org.apache.dubbo.rpc.protocol.tri.servlet.jakarta.HttpMetadataAdapter: jakarta.servlet.http.HttpServletRequest request>;	$r5 = interfaceinvoke $r4.<jakarta.servlet.http.HttpServletRequest: java.lang.String getRequestURI()>();	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(63);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 3