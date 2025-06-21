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

(declare-sort var3422 0)
(declare-sort var573 0)
(declare-sort var829 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var829_isNotEmpty/-1251449450 (String) Bool)
(declare-fun Int_valueOf/240996 (String) Int)
(declare-const null-var3422 var3422)
(declare-const null-String String)
(declare-const var601 var3422) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToShortConverter 
(assert (not (= var601 null-var3422)))
(declare-const var3817 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3817 null-String)))
(define-const var1105 Bool (var829_isNotEmpty/-1251449450 var3817)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (not (= (ite var1105 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var504 Int (Int_valueOf/240996 var3817)) ; Statement: $r2 = staticinvoke <java.lang.Short: java.lang.Short valueOf(java.lang.String)>(r0) 
 ; Statement: goto [?= return $r2] 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var829_isNotEmpty/-1251449450=([java.lang.String], boolean), Int_valueOf/240996=([java.lang.String], java.lang.Short)}
; {var3422=org.apache.dubbo.common.convert.StringToShortConverter, var601=r1, var3817=r0, var573=null_type, var829=org.apache.dubbo.common.utils.StringUtils, var1105=$z0, var504=$r2}
; {org.apache.dubbo.common.convert.StringToShortConverter=var3422, r1=var601, r0=var3817, null_type=var573, org.apache.dubbo.common.utils.StringUtils=var829, $z0=var1105, $r2=var504}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToShortConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = staticinvoke <java.lang.Short: java.lang.Short valueOf(java.lang.String)>(r0);	goto [?= return $r2];	return $r2
;block_num 3