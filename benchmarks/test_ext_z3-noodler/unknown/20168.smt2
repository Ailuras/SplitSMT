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

(declare-sort var2673 0)
(declare-sort var1467 0)
(declare-sort var1421 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun result/973410579 (var2673) var1467)
(declare-fun append/-1031950772 (String var1467) String)
(declare-fun exception/973410579 (var2673) var1421)
(declare-fun cast-from-var1421-to-var1467 (var1421) var1467)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2673 var2673)
(declare-const var12 var2673) ; Statement: r1 := @this: org.apache.dubbo.rpc.AppResponse 
(assert (not (= var12 null-var2673)))
(define-const var2255 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2255)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2255!1 String)
(assert (= var2255!1 ""))
(assert true)
(define-const var597 String (append/672562846 var2255!1 "AppResponse [value=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("AppResponse [value=") 
(declare-const var2255!2 String)
(assert (= var2255!2 (str.++ var2255!1 "AppResponse [value=")))
(define-const var3024 var1467 (result/973410579 var12)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.AppResponse: java.lang.Object result> 
(assert true)
(define-const var1621 String (append/-1031950772 var597 var3024)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var597!1 String)
(assert (str.prefixof var597 var597!1))
(assert true)
(define-const var2022 String (append/672562846 var1621 ", exception=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", exception=") 
(declare-const var1621!1 String)
(assert (= var1621!1 (str.++ var1621 ", exception=")))
(define-const var639 var1421 (exception/973410579 var12)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.AppResponse: java.lang.Throwable exception> 
(assert true)
(define-const var2692 String (append/-1031950772 var2022 (cast-from-var1421-to-var1467 var639))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var2022!1 String)
(assert (str.prefixof var2022 var2022!1))
(assert true)
(define-const var2723 String (append/672562846 var2692 "]")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var2692!1 String)
(assert (= var2692!1 (str.++ var2692 "]")))
(assert true)
(define-const var482 String (toString/-2075883882 var2723)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), result/973410579=([org.apache.dubbo.rpc.AppResponse], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), exception/973410579=([org.apache.dubbo.rpc.AppResponse], java.lang.Throwable), cast-from-var1421-to-var1467=([java.lang.Throwable], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2673=org.apache.dubbo.rpc.AppResponse, var12=r1, var2255=$r0, var597=$r3, var1467=java.lang.Object, var3024=$r2, var1621=$r4, var2022=$r6, var1421=java.lang.Throwable, var639=$r5, var2692=$r7, var2723=$r8, var482=$r9}
; {org.apache.dubbo.rpc.AppResponse=var2673, r1=var12, $r0=var2255, $r3=var597, java.lang.Object=var1467, $r2=var3024, $r4=var1621, $r6=var2022, java.lang.Throwable=var1421, $r5=var639, $r7=var2692, $r8=var2723, $r9=var482}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.AppResponse;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("AppResponse [value=");	$r2 = r1.<org.apache.dubbo.rpc.AppResponse: java.lang.Object result>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", exception=");	$r5 = r1.<org.apache.dubbo.rpc.AppResponse: java.lang.Throwable exception>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1