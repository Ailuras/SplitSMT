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

(declare-sort var368 0)
(declare-sort var3041 0)
(declare-sort var132 0)
(declare-sort var1892 0)
(declare-sort var2328 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun parameters/-202604121 (var368) var132)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var132_get/1088891777 (var132 var1892) var1892)
(declare-fun cast-from-String-to-var1892 (String) var1892)
(declare-fun cast-from-var1892-to-String (var1892) String)
(declare-fun var2328_isEmpty/-813097145 (String) Bool)
(declare-const null-var368 var368)
(declare-const null-String String)
(declare-const var3016 var368) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var3016 null-var368)))
(declare-const var2700 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var2700 null-String)))
(declare-const var1069 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var1069 null-String)))
(define-const var382 var132 (parameters/-202604121 var3016)) ; Statement: $r2 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters> 
(define-const var908 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var908)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var908!1 String)
(assert (= var908!1 ""))
(assert true)
(define-const var3143 String (append/672562846 var908!1 var2700)) ; Statement: $r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var908!2 String)
(assert (= var908!2 (str.++ var908!1 var2700)))
(assert true)
(define-const var3991 String (append/672562846 var3143 ".")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var3143!1 String)
(assert (= var3143!1 (str.++ var3143 ".")))
(assert true)
(define-const var1171 String (append/672562846 var3991 var1069)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var3991!1 String)
(assert (= var3991!1 (str.++ var3991 var1069)))
(assert true)
(define-const var710 String (toString/-2075883882 var1171)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3119 var1892 (var132_get/1088891777 var382 (cast-from-String-to-var1892 var710))) ; Statement: $r9 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>($r8) 
(define-const var2446 String (cast-from-var1892-to-String var3119)) ; Statement: r19 = (java.lang.String) $r9 
(define-const var3463 Bool (var2328_isEmpty/-813097145 var2446)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r19) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r19) 
(assert (= (ite var3463 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3749 Bool (var2328_isEmpty/-813097145 var2446)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r19) 
 ; Statement: if $z1 == 0 goto return r19 
(assert (= (ite var3749 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return r19 
(check-sat)
; {parameters/-202604121=([org.apache.dubbo.common.Parameters], java.util.Map), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var132_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1892=([java.lang.String], java.lang.Object), cast-from-var1892-to-String=([java.lang.Object], java.lang.String), var2328_isEmpty/-813097145=([java.lang.String], boolean)}
; {var368=org.apache.dubbo.common.Parameters, var3016=r0, var2700=r3, var3041=null_type, var1069=r5, var132=java.util.Map, var382=$r2, var908=$r1, var3143=$r4, var3991=$r6, var1171=$r7, var710=$r8, var1892=java.lang.Object, var3119=$r9, var2446=r19, var2328=org.apache.dubbo.common.utils.StringUtils, var3463=$z0, var3749=$z1}
; {org.apache.dubbo.common.Parameters=var368, r0=var3016, r3=var2700, null_type=var3041, r5=var1069, java.util.Map=var132, $r2=var382, $r1=var908, $r4=var3143, $r6=var3991, $r7=var1171, $r8=var710, java.lang.Object=var1892, $r9=var3119, r19=var2446, org.apache.dubbo.common.utils.StringUtils=var2328, $z0=var3463, $z1=var3749}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r3 := @parameter0: java.lang.String;	r5 := @parameter1: java.lang.String;	$r2 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters>;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	$r9 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>($r8);	r19 = (java.lang.String) $r9;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r19);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r19);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r19);	if $z1 == 0 goto return r19;	return r19
;block_num 3