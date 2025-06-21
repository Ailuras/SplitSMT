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

(declare-sort var2680 0)
(declare-sort var684 0)
(declare-sort var1759 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1759_isNotEmpty/-1251449450 (String) Bool)
(declare-fun Int_valueOf/1372619556 (String) Int)
(declare-const null-var2680 var2680)
(declare-const null-String String)
(declare-const var1308 var2680) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToIntegerConverter 
(assert (not (= var1308 null-var2680)))
(declare-const var3300 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3300 null-String)))
(define-const var852 Bool (var1759_isNotEmpty/-1251449450 var3300)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (not (= (ite var852 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2539 Int (Int_valueOf/1372619556 var3300)) ; Statement: $r2 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(java.lang.String)>(r0) 
 ; Statement: goto [?= return $r2] 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var1759_isNotEmpty/-1251449450=([java.lang.String], boolean), Int_valueOf/1372619556=([java.lang.String], java.lang.Integer)}
; {var2680=org.apache.dubbo.common.convert.StringToIntegerConverter, var1308=r1, var3300=r0, var684=null_type, var1759=org.apache.dubbo.common.utils.StringUtils, var852=$z0, var2539=$r2}
; {org.apache.dubbo.common.convert.StringToIntegerConverter=var2680, r1=var1308, r0=var3300, null_type=var684, org.apache.dubbo.common.utils.StringUtils=var1759, $z0=var852, $r2=var2539}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToIntegerConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(java.lang.String)>(r0);	goto [?= return $r2];	return $r2
;block_num 3