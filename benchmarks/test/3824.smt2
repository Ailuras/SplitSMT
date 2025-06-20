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

(declare-sort var1570 0)
(declare-sort var932 0)
(declare-sort var318 0)
(declare-sort var1139 0)
(declare-sort var2933 0)
(declare-sort var1837 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1177831711 (var1570 String) String)
(declare-fun var318_isNotEmpty/-1251449450 (String) Bool)
(declare-fun METHOD_PARAMETERS/458914123 (var1570) var1139)
(declare-fun var1139_get/1088891777 (var1139 var2933) var2933)
(declare-fun cast-from-String-to-var2933 (String) var2933)
(declare-fun cast-from-var2933-to-var1139 (var2933) var1139)
(declare-fun var1837_isNotEmptyMap/1884409606 (var1139) Bool)
(declare-const null-var1570 var1570)
(declare-const null-String String)
(declare-const var1373 var1570) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.URLParam 
(assert (not (= var1373 null-var1570)))
(declare-const var3120 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var3120 null-String)))
(declare-const var3198 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3198 null-String)))
(assert true)
(define-const var196 String (getParameter/-1177831711 var1373 "methods")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>("methods") 
(define-const var1264 Bool (var318_isNotEmpty/-1251449450 var196)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.common.url.component.URLParam: java.util.Map METHOD_PARAMETERS> 
(assert (= (ite var1264 1 0) 0)) ; Cond: $z0 == 0 
(define-const var653 var1139 (METHOD_PARAMETERS/458914123 var1373)) ; Statement: $r3 = r0.<org.apache.dubbo.common.url.component.URLParam: java.util.Map METHOD_PARAMETERS> 
(define-const var992 var2933 (var1139_get/1088891777 var653 (cast-from-String-to-var2933 var3198))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2) 
(define-const var1360 var1139 (cast-from-var2933-to-var1139 var992)) ; Statement: $r8 = (java.util.Map) $r4 
(define-const var3081 Bool (var1837_isNotEmptyMap/1884409606 var1360)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>($r8) 
 ; Statement: if $z1 == 0 goto return null 
(assert (= (ite var3081 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return null 
(check-sat)
; {getParameter/-1177831711=([org.apache.dubbo.common.url.component.URLParam, java.lang.String], java.lang.String), var318_isNotEmpty/-1251449450=([java.lang.String], boolean), METHOD_PARAMETERS/458914123=([org.apache.dubbo.common.url.component.URLParam], java.util.Map), var1139_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var2933=([java.lang.String], java.lang.Object), cast-from-var2933-to-var1139=([java.lang.Object], java.util.Map), var1837_isNotEmptyMap/1884409606=([java.util.Map], boolean)}
; {var1570=org.apache.dubbo.common.url.component.URLParam, var1373=r0, var3120=r5, var932=null_type, var3198=r2, var196=r1, var318=org.apache.dubbo.common.utils.StringUtils, var1264=$z0, var1139=java.util.Map, var653=$r3, var2933=java.lang.Object, var992=$r4, var1360=$r8, var1837=org.apache.dubbo.common.utils.CollectionUtils, var3081=$z1}
; {org.apache.dubbo.common.url.component.URLParam=var1570, r0=var1373, r5=var3120, null_type=var932, r2=var3198, r1=var196, org.apache.dubbo.common.utils.StringUtils=var318, $z0=var1264, java.util.Map=var1139, $r3=var653, java.lang.Object=var2933, $r4=var992, $r8=var1360, org.apache.dubbo.common.utils.CollectionUtils=var1837, $z1=var3081}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.URLParam;	r5 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r1 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>("methods");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.common.url.component.URLParam: java.util.Map METHOD_PARAMETERS>;	$r3 = r0.<org.apache.dubbo.common.url.component.URLParam: java.util.Map METHOD_PARAMETERS>;	$r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2);	$r8 = (java.util.Map) $r4;	$z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>($r8);	if $z1 == 0 goto return null;	return null
;block_num 3