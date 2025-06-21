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

(declare-sort var1981 0)
(declare-sort var1408 0)
(declare-sort var2966 0)
(declare-sort var3928 0)
(declare-sort var841 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun parameters/-202604121 (var1981) var2966)
(declare-fun var2966_get/1088891777 (var2966 var3928) var3928)
(declare-fun cast-from-String-to-var3928 (String) var3928)
(declare-fun cast-from-var3928-to-String (var3928) String)
(declare-fun var841_isEmpty/-813097145 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1981 var1981)
(declare-const null-String String)
(declare-const var1666 var1981) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var1666 null-var1981)))
(declare-const var1797 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1797 null-String)))
(define-const var477 var2966 (parameters/-202604121 var1666)) ; Statement: $r2 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters> 
(define-const var714 var3928 (var2966_get/1088891777 var477 (cast-from-String-to-var3928 var1797))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var3481 String (cast-from-var3928-to-String var714)) ; Statement: r22 = (java.lang.String) $r3 
(define-const var3871 Bool (var841_isEmpty/-813097145 var3481)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
(assert (= (ite var3871 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3158 Bool (var841_isEmpty/-813097145 var3481)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
 ; Statement: if $z1 == 0 goto $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
(assert (not (= (ite var3158 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var2070 var2966 (parameters/-202604121 var1666)) ; Statement: $r11 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters> 
(define-const var1559 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1559)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1559!1 String)
(assert (= var1559!1 ""))
(assert true)
(define-const var1755 String (append/672562846 var1559!1 "default.")) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("default.") 
(declare-const var1559!2 String)
(assert (= var1559!2 (str.++ var1559!1 "default.")))
(assert true)
(define-const var1013 String (append/672562846 var1755 var1797)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1755!1 String)
(assert (= var1755!1 (str.++ var1755 var1797)))
(assert true)
(define-const var2871 String (toString/-2075883882 var1013)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var48 var3928 (var2966_get/1088891777 var2070 (cast-from-String-to-var3928 var2871))) ; Statement: $r15 = interfaceinvoke $r11.<java.util.Map: java.lang.Object get(java.lang.Object)>($r14) 
(define-const var3481!1 String (cast-from-var3928-to-String var48)) ; Statement: r22 = (java.lang.String) $r15 
(assert true) ; Non Conditional
(define-const var448 Bool (var841_isEmpty/-813097145 var3481!1)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
 ; Statement: if $z2 == 0 goto return r22 
(assert (= (ite var448 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return r22 
(check-sat)
; {parameters/-202604121=([org.apache.dubbo.common.Parameters], java.util.Map), var2966_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3928=([java.lang.String], java.lang.Object), cast-from-var3928-to-String=([java.lang.Object], java.lang.String), var841_isEmpty/-813097145=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1981=org.apache.dubbo.common.Parameters, var1666=r0, var1797=r1, var1408=null_type, var2966=java.util.Map, var477=$r2, var3928=java.lang.Object, var714=$r3, var3481=r22, var841=org.apache.dubbo.common.utils.StringUtils, var3871=$z0, var3158=$z1, var2070=$r11, var1559=$r10, var1755=$r12, var1013=$r13, var2871=$r14, var48=$r15, var448=$z2}
; {org.apache.dubbo.common.Parameters=var1981, r0=var1666, r1=var1797, null_type=var1408, java.util.Map=var2966, $r2=var477, java.lang.Object=var3928, $r3=var714, r22=var3481, org.apache.dubbo.common.utils.StringUtils=var841, $z0=var3871, $z1=var3158, $r11=var2070, $r10=var1559, $r12=var1755, $r13=var1013, $r14=var2871, $r15=var48, $z2=var448}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 3,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	$r2 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters>;	$r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1);	r22 = (java.lang.String) $r3;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	if $z1 == 0 goto $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	$r11 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters>;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("default.");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	$r15 = interfaceinvoke $r11.<java.util.Map: java.lang.Object get(java.lang.Object)>($r14);	r22 = (java.lang.String) $r15;	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	if $z2 == 0 goto return r22;	return r22
;block_num 5