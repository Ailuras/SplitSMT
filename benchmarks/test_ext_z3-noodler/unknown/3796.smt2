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

(declare-sort var3291 0)
(declare-sort var1068 0)
(declare-sort var3865 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1177831711 (var3291 String) String)
(declare-fun var3865_isNotEmpty/-1251449450 (String) Bool)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var3291 var3291)
(declare-const null-String String)
(declare-const var2830 var3291) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.URLParam 
(assert (not (= var2830 null-var3291)))
(declare-const var887 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var887 null-String)))
(declare-const var765 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var765 null-String)))
(assert true)
(define-const var1652 String (getParameter/-1177831711 var2830 "methods")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>("methods") 
(define-const var2765 Bool (var3865_isNotEmpty/-1251449450 var1652)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.common.url.component.URLParam: java.util.Map METHOD_PARAMETERS> 
(assert (not (= (ite var2765 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3684 Bool (contains/1009244746 var1652 (cast-from-String-to-String var887))) ; Statement: $z2 = virtualinvoke r1.<java.lang.String: boolean contains(java.lang.CharSequence)>(r5) 
 ; Statement: if $z2 != 0 goto $r3 = r0.<org.apache.dubbo.common.url.component.URLParam: java.util.Map METHOD_PARAMETERS> 
(assert (not (not (= (ite var3684 1 0) 0)))) ; Negate: Cond: $z2 != 0  
 ; Statement: return null 
(check-sat)
; {getParameter/-1177831711=([org.apache.dubbo.common.url.component.URLParam, java.lang.String], java.lang.String), var3865_isNotEmpty/-1251449450=([java.lang.String], boolean), contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var3291=org.apache.dubbo.common.url.component.URLParam, var2830=r0, var887=r5, var1068=null_type, var765=r2, var1652=r1, var3865=org.apache.dubbo.common.utils.StringUtils, var2765=$z0, var3684=$z2}
; {org.apache.dubbo.common.url.component.URLParam=var3291, r0=var2830, r5=var887, null_type=var1068, r2=var765, r1=var1652, org.apache.dubbo.common.utils.StringUtils=var3865, $z0=var2765, $z2=var3684}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.URLParam;	r5 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r1 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>("methods");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.common.url.component.URLParam: java.util.Map METHOD_PARAMETERS>;	$z2 = virtualinvoke r1.<java.lang.String: boolean contains(java.lang.CharSequence)>(r5);	if $z2 != 0 goto $r3 = r0.<org.apache.dubbo.common.url.component.URLParam: java.util.Map METHOD_PARAMETERS>;	return null
;block_num 3