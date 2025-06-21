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

(declare-sort var840 0)
(declare-sort var2690 0)
(declare-sort var3834 0)
(declare-sort var431 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2690_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var431_emptyMap/401053835 () var3834)
(declare-const null-String String)
(declare-const var1909 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1909 null-String)))
(define-const var1226 Bool (var2690_isBlank/-523695098 (cast-from-String-to-String var1909))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = <org.apache.dubbo.common.utils.StringUtils: java.util.regex.Pattern PARAMETERS_PATTERN> 
(assert (not (= (ite var1226 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var746 var3834 var431_emptyMap/401053835) ; Statement: $r12 = staticinvoke <java.util.Collections: java.util.Map emptyMap()>() 
 ; Statement: return $r12 
(check-sat)
; {var2690_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var431_emptyMap/401053835=([], java.util.Map)}
; {var1909=r0, var840=null_type, var2690=org.apache.dubbo.common.utils.StringUtils, var1226=$z0, var3834=java.util.Map, var431=java.util.Collections, var746=$r12}
; {r0=var1909, null_type=var840, org.apache.dubbo.common.utils.StringUtils=var2690, $z0=var1226, java.util.Map=var3834, java.util.Collections=var431, $r12=var746}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $r1 = <org.apache.dubbo.common.utils.StringUtils: java.util.regex.Pattern PARAMETERS_PATTERN>;	$r12 = staticinvoke <java.util.Collections: java.util.Map emptyMap()>();	return $r12
;block_num 2