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

(declare-sort var712 0)
(declare-sort var1052 0)
(declare-sort var2587 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameterStrict/-1583757214 (var712 String String) String)
(declare-fun var2587_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var712 var712)
(declare-const null-String String)
(declare-const var3109 var712) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.URLParam 
(assert (not (= var3109 null-var712)))
(declare-const var2599 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2599 null-String)))
(declare-const var249 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var249 null-String)))
(assert true)
(define-const var3213 String (getMethodParameterStrict/-1583757214 var3109 var2599 var249)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getMethodParameterStrict(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1955 Bool (var2587_isNotEmpty/-1251449450 var3213)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r4 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>(r2) 
(assert (not (= (ite var1955 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var200 String var3213) ; Statement: $r4 = r3 
 ; Statement: goto [?= return $r4] 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {getMethodParameterStrict/-1583757214=([org.apache.dubbo.common.url.component.URLParam, java.lang.String, java.lang.String], java.lang.String), var2587_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var712=org.apache.dubbo.common.url.component.URLParam, var3109=r0, var2599=r1, var1052=null_type, var249=r2, var3213=r3, var2587=org.apache.dubbo.common.utils.StringUtils, var1955=$z0, var200=$r4}
; {org.apache.dubbo.common.url.component.URLParam=var712, r0=var3109, r1=var2599, null_type=var1052, r2=var249, r3=var3213, org.apache.dubbo.common.utils.StringUtils=var2587, $z0=var1955, $r4=var200}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.URLParam;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getMethodParameterStrict(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r4 = virtualinvoke r0.<org.apache.dubbo.common.url.component.URLParam: java.lang.String getParameter(java.lang.String)>(r2);	$r4 = r3;	goto [?= return $r4];	return $r4
;block_num 3