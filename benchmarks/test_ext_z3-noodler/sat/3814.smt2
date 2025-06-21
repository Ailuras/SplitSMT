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

(declare-sort var3570 0)
(declare-sort var938 0)
(declare-sort var1903 0)
(declare-sort var2492 0)
(declare-sort var3333 0)
(declare-sort var2235 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1177831711 (var3570 String) String)
(declare-fun var1903_isNotEmpty/-1251449450 (String) Bool)
(declare-fun METHOD_PARAMETERS/458914123 (var3570) var2492)
(declare-fun var2492_get/1088891777 (var2492 var3333) var3333)
(declare-fun cast-from-String-to-var3333 (String) var3333)
(declare-fun cast-from-var3333-to-var2492 (var3333) var2492)
(declare-fun var2235_isNotEmptyMap/1884409606 (var2492) Bool)
(declare-fun cast-from-var3333-to-String (var3333) String)
(declare-const null-var3570 var3570)
(declare-const null-String String)
(declare-const var3891 var3570) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.URLParam 
(assert (not (= var3891 null-var3570)))
(declare-const var3944 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var3944 null-String)))
(declare-const var3880 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3880 null-String)))
(assert true)
(define-const var2570 String (getParameter/-1177831711 var3891 "methods")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>("methods") 
(define-const var1743 Bool (var1903_isNotEmpty/-1251449450 var2570)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.common.url.component.URLParam: java.util.Map METHOD_PARAMETERS> 
(assert (= (ite var1743 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3154 var2492 (METHOD_PARAMETERS/458914123 var3891)) ; Statement: $r3 = r0.<org.apache.dubbo.common.url.component.URLParam: java.util.Map METHOD_PARAMETERS> 
(define-const var759 var3333 (var2492_get/1088891777 var3154 (cast-from-String-to-var3333 var3880))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2) 
(define-const var3396 var2492 (cast-from-var3333-to-var2492 var759)) ; Statement: $r8 = (java.util.Map) $r4 
(define-const var1714 Bool (var2235_isNotEmptyMap/1884409606 var3396)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>($r8) 
 ; Statement: if $z1 == 0 goto return null 
(assert (not (= (ite var1714 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var624 var3333 (var2492_get/1088891777 var3396 (cast-from-String-to-var3333 var3944))) ; Statement: $r6 = interfaceinvoke $r8.<java.util.Map: java.lang.Object get(java.lang.Object)>(r5) 
(define-const var1872 String (cast-from-var3333-to-String var624)) ; Statement: $r7 = (java.lang.String) $r6 
 ; Statement: return $r7 
(check-sat)
; {getParameter/-1177831711=([org.apache.dubbo.common.url.component.URLParam, java.lang.String], java.lang.String), var1903_isNotEmpty/-1251449450=([java.lang.String], boolean), METHOD_PARAMETERS/458914123=([org.apache.dubbo.common.url.component.URLParam], java.util.Map), var2492_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3333=([java.lang.String], java.lang.Object), cast-from-var3333-to-var2492=([java.lang.Object], java.util.Map), var2235_isNotEmptyMap/1884409606=([java.util.Map], boolean), cast-from-var3333-to-String=([java.lang.Object], java.lang.String)}
; {var3570=org.apache.dubbo.common.url.component.URLParam, var3891=r0, var3944=r5, var938=null_type, var3880=r2, var2570=r1, var1903=org.apache.dubbo.common.utils.StringUtils, var1743=$z0, var2492=java.util.Map, var3154=$r3, var3333=java.lang.Object, var759=$r4, var3396=$r8, var2235=org.apache.dubbo.common.utils.CollectionUtils, var1714=$z1, var624=$r6, var1872=$r7}
; {org.apache.dubbo.common.url.component.URLParam=var3570, r0=var3891, r5=var3944, null_type=var938, r2=var3880, r1=var2570, org.apache.dubbo.common.utils.StringUtils=var1903, $z0=var1743, java.util.Map=var2492, $r3=var3154, java.lang.Object=var3333, $r4=var759, $r8=var3396, org.apache.dubbo.common.utils.CollectionUtils=var2235, $z1=var1714, $r6=var624, $r7=var1872}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.URLParam;	r5 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r1 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>("methods");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.common.url.component.URLParam: java.util.Map METHOD_PARAMETERS>;	$r3 = r0.<org.apache.dubbo.common.url.component.URLParam: java.util.Map METHOD_PARAMETERS>;	$r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2);	$r8 = (java.util.Map) $r4;	$z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>($r8);	if $z1 == 0 goto return null;	$r6 = interfaceinvoke $r8.<java.util.Map: java.lang.Object get(java.lang.Object)>(r5);	$r7 = (java.lang.String) $r6;	return $r7
;block_num 3