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

(declare-sort var2797 0)
(declare-sort var1094 0)
(declare-sort var2428 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var2797_get/1088891777 (var2797 var1094) var1094)
(declare-fun cast-from-String-to-var1094 (String) var1094)
(declare-fun cast-from-var1094-to-String (var1094) String)
(declare-fun var2428_isNotEmpty/-1251449450 (String) Bool)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2797 var2797)
(declare-const var2772 var2797) ; Statement: r1 := @parameter0: java.util.Map 
(assert (not (= var2772 null-var2797)))
(define-const var3876 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3876)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3876!1 String)
(assert (= var3876!1 ""))
(define-const var789 var1094 (var2797_get/1088891777 var2772 (cast-from-String-to-var1094 "group"))) ; Statement: $r2 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("group") 
(define-const var833 String (cast-from-var1094-to-String var789)) ; Statement: r3 = (java.lang.String) $r2 
(define-const var1754 Bool (var2428_isNotEmpty/-1251449450 var833)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r4 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface") 
(assert (= (ite var1754 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1342 var1094 (var2797_get/1088891777 var2772 (cast-from-String-to-var1094 "interface"))) ; Statement: $r4 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface") 
(define-const var1085 String (cast-from-var1094-to-String var1342)) ; Statement: $r5 = (java.lang.String) $r4 
(assert true)
;(assert (append/672562846 var3876!1 var1085)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3876!2 String)
(assert (= var3876!2 (str.++ var3876!1 var1085)))
(define-const var593 var1094 (var2797_get/1088891777 var2772 (cast-from-String-to-var1094 "version"))) ; Statement: $r6 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("version") 
(define-const var3287 String (cast-from-var1094-to-String var593)) ; Statement: $r10 = (java.lang.String) $r6 
(define-const var2347 Bool (var2428_isNotEmpty/-1251449450 var833)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z1 == 0 goto $r7 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var2347 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var1396 String (toString/-2075883882 var3876!2)) ; Statement: $r7 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var2797_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1094=([java.lang.String], java.lang.Object), cast-from-var1094-to-String=([java.lang.Object], java.lang.String), var2428_isNotEmpty/-1251449450=([java.lang.String], boolean), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2797=java.util.Map, var2772=r1, var3876=$r0, var1094=java.lang.Object, var789=$r2, var833=r3, var2428=org.apache.dubbo.common.utils.StringUtils, var1754=$z0, var1342=$r4, var1085=$r5, var593=$r6, var3287=$r10, var2347=$z1, var1396=$r7}
; {java.util.Map=var2797, r1=var2772, $r0=var3876, java.lang.Object=var1094, $r2=var789, r3=var833, org.apache.dubbo.common.utils.StringUtils=var2428, $z0=var1754, $r4=var1342, $r5=var1085, $r6=var593, $r10=var3287, $z1=var2347, $r7=var1396}
;seq <java.lang.StringBuilder: void <init>()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.util.Map;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("group");	r3 = (java.lang.String) $r2;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r4 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface");	$r4 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface");	$r5 = (java.lang.String) $r4;	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r6 = interfaceinvoke r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("version");	$r10 = (java.lang.String) $r6;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z1 == 0 goto $r7 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r7 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 3