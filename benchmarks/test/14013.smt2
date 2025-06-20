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

(declare-sort var2977 0)
(declare-sort var1526 0)
(declare-sort var835 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun request/1050097413 (var2977) var1526)
(declare-fun var1526_getQueryString/-1000889952 (var1526) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1526_getRequestURI/-1504339324 (var1526) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2977 var2977)
(declare-const null-String String)
(declare-const var2552 var2977) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.HttpMetadataAdapter 
(assert (not (= var2552 null-var2977)))
(define-const var3810 var1526 (request/1050097413 var2552)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.servlet.HttpMetadataAdapter: javax.servlet.http.HttpServletRequest request> 
(define-const var1214 String (var1526_getQueryString/-1000889952 var3810)) ; Statement: r2 = interfaceinvoke $r1.<javax.servlet.http.HttpServletRequest: java.lang.String getQueryString()>() 
 ; Statement: if r2 != null goto $r3 = new java.lang.StringBuilder 
(assert (not (= var1214 null-String))) ; Cond: r2 != null 
(define-const var1348 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1348)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1348!1 String)
(assert (= var1348!1 ""))
(define-const var2428 var1526 (request/1050097413 var2552)) ; Statement: $r4 = r0.<org.apache.dubbo.rpc.protocol.tri.servlet.HttpMetadataAdapter: javax.servlet.http.HttpServletRequest request> 
(define-const var1992 String (var1526_getRequestURI/-1504339324 var2428)) ; Statement: $r5 = interfaceinvoke $r4.<javax.servlet.http.HttpServletRequest: java.lang.String getRequestURI()>() 
(assert true)
(define-const var3459 String (append/672562846 var1348!1 var1992)) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var1348!2 String)
(assert (= var1348!2 (str.++ var1348!1 var1992)))
(assert true)
(define-const var2261 String (append/-1166366385 var3459 63)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(63) 
(declare-const var3459!1 String)
(assert (str.prefixof var3459 var3459!1))
(assert true)
(define-const var2332 String (append/672562846 var2261 var1214)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2261!1 String)
(assert (= var2261!1 (str.++ var2261 var1214)))
(assert true)
(define-const var3394 String (toString/-2075883882 var2332)) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
 ; Statement: return $r10 
(check-sat)
; {request/1050097413=([org.apache.dubbo.rpc.protocol.tri.servlet.HttpMetadataAdapter], javax.servlet.http.HttpServletRequest), var1526_getQueryString/-1000889952=([javax.servlet.http.HttpServletRequest], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1526_getRequestURI/-1504339324=([javax.servlet.http.HttpServletRequest], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2977=org.apache.dubbo.rpc.protocol.tri.servlet.HttpMetadataAdapter, var2552=r0, var1526=javax.servlet.http.HttpServletRequest, var3810=$r1, var1214=r2, var835=null_type, var1348=$r3, var2428=$r4, var1992=$r5, var3459=$r6, var2261=$r7, var2332=$r8, var3394=$r10}
; {org.apache.dubbo.rpc.protocol.tri.servlet.HttpMetadataAdapter=var2977, r0=var2552, javax.servlet.http.HttpServletRequest=var1526, $r1=var3810, r2=var1214, null_type=var835, $r3=var1348, $r4=var2428, $r5=var1992, $r6=var3459, $r7=var2261, $r8=var2332, $r10=var3394}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.servlet.HttpMetadataAdapter;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.servlet.HttpMetadataAdapter: javax.servlet.http.HttpServletRequest request>;	r2 = interfaceinvoke $r1.<javax.servlet.http.HttpServletRequest: java.lang.String getQueryString()>();	if r2 != null goto $r3 = new java.lang.StringBuilder;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = r0.<org.apache.dubbo.rpc.protocol.tri.servlet.HttpMetadataAdapter: javax.servlet.http.HttpServletRequest request>;	$r5 = interfaceinvoke $r4.<javax.servlet.http.HttpServletRequest: java.lang.String getRequestURI()>();	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(63);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 3