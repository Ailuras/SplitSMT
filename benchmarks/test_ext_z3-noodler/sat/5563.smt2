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

(declare-sort var2369 0)
(declare-sort var1184 0)
(declare-sort var3820 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3820_splitToSet/395946401 (String Int Bool) var1184)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1948 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1948 null-String)))
(declare-const var3810 Int) ; Statement: c0 := @parameter1: char 
(assert (not (= var3810 null-Int)))
(define-const var1546 var1184 (var3820_splitToSet/395946401 var1948 var3810 (ite (= 1 0) true false))) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Set splitToSet(java.lang.String,char,boolean)>(r0, c0, 0) 
 ; Statement: return $r1 
(check-sat)
; {var3820_splitToSet/395946401=([java.lang.String, char, boolean], java.util.Set)}
; {var1948=r0, var2369=null_type, var3810=c0, var1184=java.util.Set, var3820=org.apache.dubbo.common.utils.StringUtils, var1546=$r1}
; {r0=var1948, null_type=var2369, c0=var3810, java.util.Set=var1184, org.apache.dubbo.common.utils.StringUtils=var3820, $r1=var1546}
;seq <org.apache.dubbo.common.utils.StringUtils: java.util.Set splitToSet(java.lang.String,char,boolean)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.util.Set splitToSet(java.lang.String,char,boolean)>": 1}
;stmts r0 := @parameter0: java.lang.String;	c0 := @parameter1: char;	$r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Set splitToSet(java.lang.String,char,boolean)>(r0, c0, 0);	return $r1
;block_num 1