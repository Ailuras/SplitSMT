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

(declare-sort var2078 0)
(declare-sort var3454 0)
(declare-sort var3480 0)
(declare-sort var2387 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3454_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2387_emptySet/2131139019 () var3480)
(declare-const null-String String)
(declare-const var1589 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1589 null-String)))
(define-const var3531 Bool (var3454_isBlank/-523695098 (cast-from-String-to-String var1589))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.util.TreeSet 
(assert (not (= (ite var3531 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2037 var3480 var2387_emptySet/2131139019) ; Statement: $r11 = staticinvoke <java.util.Collections: java.util.Set emptySet()>() 
 ; Statement: return $r11 
(check-sat)
; {var3454_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2387_emptySet/2131139019=([], java.util.Set)}
; {var1589=r0, var2078=null_type, var3454=org.apache.dubbo.common.utils.StringUtils, var3531=$z0, var3480=java.util.Set, var2387=java.util.Collections, var2037=$r11}
; {r0=var1589, null_type=var2078, org.apache.dubbo.common.utils.StringUtils=var3454, $z0=var3531, java.util.Set=var3480, java.util.Collections=var2387, $r11=var2037}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $r1 = new java.util.TreeSet;	$r11 = staticinvoke <java.util.Collections: java.util.Set emptySet()>();	return $r11
;block_num 2