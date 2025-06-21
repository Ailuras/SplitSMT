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

(declare-sort var1774 0)
(declare-sort var1867 0)
(declare-sort var675 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameterStrict/-1583757214 (var1774 String String) String)
(declare-fun var675_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getParameter/-1177831711 (var1774 String) String)
(declare-const null-var1774 var1774)
(declare-const null-String String)
(declare-const var637 var1774) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.URLParam 
(assert (not (= var637 null-var1774)))
(declare-const var1206 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1206 null-String)))
(declare-const var2994 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2994 null-String)))
(assert true)
(define-const var3316 String (getMethodParameterStrict/-1583757214 var637 var1206 var2994)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getMethodParameterStrict(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var645 Bool (var675_isNotEmpty/-1251449450 var3316)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r4 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>(r2) 
(assert (= (ite var645 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1856 String (getParameter/-1177831711 var637 var2994)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>(r2) 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {getMethodParameterStrict/-1583757214=([org.apache.dubbo.common.url.component.URLParam, java.lang.String, java.lang.String], java.lang.String), var675_isNotEmpty/-1251449450=([java.lang.String], boolean), getParameter/-1177831711=([org.apache.dubbo.common.url.component.URLParam, java.lang.String], java.lang.String)}
; {var1774=org.apache.dubbo.common.url.component.URLParam, var637=r0, var1206=r1, var1867=null_type, var2994=r2, var3316=r3, var675=org.apache.dubbo.common.utils.StringUtils, var645=$z0, var1856=$r4}
; {org.apache.dubbo.common.url.component.URLParam=var1774, r0=var637, r1=var1206, null_type=var1867, r2=var2994, r3=var3316, org.apache.dubbo.common.utils.StringUtils=var675, $z0=var645, $r4=var1856}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.URLParam;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getMethodParameterStrict(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r4 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>(r2);	$r4 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>(r2);	return $r4
;block_num 3