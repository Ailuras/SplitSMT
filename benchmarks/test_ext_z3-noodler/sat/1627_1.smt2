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

(declare-sort var3956 0)
(declare-sort var619 0)
(declare-sort var2103 0)
(declare-sort var476 0)
(declare-sort var2348 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun parameters/-202604121 (var3956) var2103)
(declare-fun var2103_get/1088891777 (var2103 var476) var476)
(declare-fun cast-from-String-to-var476 (String) var476)
(declare-fun cast-from-var476-to-String (var476) String)
(declare-fun var2348_isEmpty/-813097145 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3956 var3956)
(declare-const null-String String)
(declare-const var225 var3956) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var225 null-var3956)))
(declare-const var1832 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1832 null-String)))
(define-const var1212 var2103 (parameters/-202604121 var225)) ; Statement: $r2 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters> 
(define-const var2790 var476 (var2103_get/1088891777 var1212 (cast-from-String-to-var476 var1832))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var2215 String (cast-from-var476-to-String var2790)) ; Statement: r22 = (java.lang.String) $r3 
(define-const var1458 Bool (var2348_isEmpty/-813097145 var2215)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
(assert (not (= (ite var1458 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2538 var2103 (parameters/-202604121 var225)) ; Statement: $r17 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters> 
(define-const var3368 String String-init) ; Statement: $r16 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3368)) ; Statement: specialinvoke $r16.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3368!1 String)
(assert (= var3368!1 ""))
(assert true)
(define-const var1483 String (append/672562846 var3368!1 ".")) ; Statement: $r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var3368!2 String)
(assert (= var3368!2 (str.++ var3368!1 ".")))
(assert true)
(define-const var3794 String (append/672562846 var1483 var1832)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1483!1 String)
(assert (= var1483!1 (str.++ var1483 var1832)))
(assert true)
(define-const var2320 String (toString/-2075883882 var3794)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3828 var476 (var2103_get/1088891777 var2538 (cast-from-String-to-var476 var2320))) ; Statement: $r21 = interfaceinvoke $r17.<java.util.Map: java.lang.Object get(java.lang.Object)>($r20) 
(define-const var2215!1 String (cast-from-var476-to-String var3828)) ; Statement: r22 = (java.lang.String) $r21 
(assert true) ; Non Conditional
(define-const var426 Bool (var2348_isEmpty/-813097145 var2215!1)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
 ; Statement: if $z1 == 0 goto $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
(assert (= (ite var426 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3779 Bool (var2348_isEmpty/-813097145 var2215!1)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22) 
 ; Statement: if $z2 == 0 goto return r22 
(assert (= (ite var3779 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return r22 
(check-sat)
; {parameters/-202604121=([org.apache.dubbo.common.Parameters], java.util.Map), var2103_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var476=([java.lang.String], java.lang.Object), cast-from-var476-to-String=([java.lang.Object], java.lang.String), var2348_isEmpty/-813097145=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3956=org.apache.dubbo.common.Parameters, var225=r0, var1832=r1, var619=null_type, var2103=java.util.Map, var1212=$r2, var476=java.lang.Object, var2790=$r3, var2215=r22, var2348=org.apache.dubbo.common.utils.StringUtils, var1458=$z0, var2538=$r17, var3368=$r16, var1483=$r18, var3794=$r19, var2320=$r20, var3828=$r21, var426=$z1, var3779=$z2}
; {org.apache.dubbo.common.Parameters=var3956, r0=var225, r1=var1832, null_type=var619, java.util.Map=var2103, $r2=var1212, java.lang.Object=var476, $r3=var2790, r22=var2215, org.apache.dubbo.common.utils.StringUtils=var2348, $z0=var1458, $r17=var2538, $r16=var3368, $r18=var1483, $r19=var3794, $r20=var2320, $r21=var3828, $z1=var426, $z2=var3779}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 3,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	$r2 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters>;	$r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1);	r22 = (java.lang.String) $r3;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	$r17 = r0.<org.apache.dubbo.common.Parameters: java.util.Map parameters>;	$r16 = new java.lang.StringBuilder;	specialinvoke $r16.<java.lang.StringBuilder: void <init>()>();	$r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	$r21 = interfaceinvoke $r17.<java.util.Map: java.lang.Object get(java.lang.Object)>($r20);	r22 = (java.lang.String) $r21;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	if $z1 == 0 goto $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r22);	if $z2 == 0 goto return r22;	return r22
;block_num 5