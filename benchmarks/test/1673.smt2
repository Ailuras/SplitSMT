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

(declare-sort var3334 0)
(declare-sort var49 0)
(declare-sort var2586 0)
(declare-sort var1504 0)
(declare-sort var2942 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun parameters/-202604121 (var3334) var2586)
(declare-fun var2586_get/1088891777 (var2586 var1504) var1504)
(declare-fun cast-from-String-to-var1504 (String) var1504)
(declare-fun cast-from-var1504-to-String (var1504) String)
(declare-fun var2942_isEmpty/-813097145 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3334 var3334)
(declare-const null-String String)
(declare-const var1764 var3334) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var1764 null-var3334)))
(declare-const var681 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var681 null-String)))
(define-const var746 var2586 (parameters/-202604121 var1764)) ; Statement: $r2 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters> 
(define-const var2654 var1504 (var2586_get/1088891777 var746 (cast-from-String-to-var1504 var681))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var461 String (cast-from-var1504-to-String var2654)) ; Statement: r22 = (java.lang.String) $r3 
(define-const var1957 Bool (var2942_isEmpty/-813097145 var461)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
(assert (= (ite var1957 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2576 Bool (var2942_isEmpty/-813097145 var461)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
 ; Statement: if $z1 == 0 goto $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
(assert (= (ite var2576 1 0) 0)) ; Cond: $z1 == 0 
(define-const var776 Bool (var2942_isEmpty/-813097145 var461)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
 ; Statement: if $z2 == 0 goto return r22 
(assert (not (= (ite var776 1 0) 0))) ; Negate: Cond: $z2 == 0  
(define-const var1390 var2586 (parameters/-202604121 var1764)) ; Statement: $r5 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters> 
(define-const var902 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var902)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var902!1 String)
(assert (= var902!1 ""))
(assert true)
(define-const var792 String (append/672562846 var902!1 ".default.")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".default.") 
(declare-const var902!2 String)
(assert (= var902!2 (str.++ var902!1 ".default.")))
(assert true)
(define-const var3303 String (append/672562846 var792 var681)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var792!1 String)
(assert (= var792!1 (str.++ var792 var681)))
(assert true)
(define-const var3216 String (toString/-2075883882 var3303)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1958 var1504 (var2586_get/1088891777 var1390 (cast-from-String-to-var1504 var3216))) ; Statement: $r9 = interfaceinvoke $r5.<java.util.Map: java.lang.Object get(java.lang.Object)>($r8) 
(define-const var461!1 String (cast-from-var1504-to-String var1958)) ; Statement: r22 = (java.lang.String) $r9 
(assert true) ; Non Conditional
 ; Statement: return r22 
(check-sat)
; {parameters/-202604121=([org.apache.dubbo.common.Parameters], java.util.Map), var2586_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1504=([java.lang.String], java.lang.Object), cast-from-var1504-to-String=([java.lang.Object], java.lang.String), var2942_isEmpty/-813097145=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3334=org.apache.dubbo.common.Parameters, var1764=r0, var681=r1, var49=null_type, var2586=java.util.Map, var746=$r2, var1504=java.lang.Object, var2654=$r3, var461=r22, var2942=org.apache.dubbo.common.utils.StringUtils, var1957=$z0, var2576=$z1, var776=$z2, var1390=$r5, var902=$r4, var792=$r6, var3303=$r7, var3216=$r8, var1958=$r9}
; {org.apache.dubbo.common.Parameters=var3334, r0=var1764, r1=var681, null_type=var49, java.util.Map=var2586, $r2=var746, java.lang.Object=var1504, $r3=var2654, r22=var461, org.apache.dubbo.common.utils.StringUtils=var2942, $z0=var1957, $z1=var2576, $z2=var776, $r5=var1390, $r4=var902, $r6=var792, $r7=var3303, $r8=var3216, $r9=var1958}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 3,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	$r2 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters>;	$r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1);	r22 = (java.lang.String) $r3;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	if $z1 == 0 goto $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	if $z2 == 0 goto return r22;	$r5 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters>;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".default.");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	$r9 = interfaceinvoke $r5.<java.util.Map: java.lang.Object get(java.lang.Object)>($r8);	r22 = (java.lang.String) $r9;	return r22
;block_num 5