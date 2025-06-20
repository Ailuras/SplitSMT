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

(declare-sort var3076 0)
(declare-sort var2727 0)
(declare-sort var996 0)
(declare-sort var422 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2727_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var422_emptySet/2131139019 () var996)
(declare-const null-String String)
(declare-const var1300 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1300 null-String)))
(define-const var2285 Bool (var2727_isBlank/-523695098 (cast-from-String-to-String var1300))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.util.TreeSet 
(assert (not (= (ite var2285 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var204 var996 var422_emptySet/2131139019) ; Statement: $r11 = staticinvoke <java.util.Collections: java.util.Set emptySet()>() 
 ; Statement: goto [?= return $r11] 
(assert true) ; Non Conditional
 ; Statement: return $r11 
(check-sat)
; {var2727_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var422_emptySet/2131139019=([], java.util.Set)}
; {var1300=r0, var3076=null_type, var2727=org.apache.dubbo.common.utils.StringUtils, var2285=$z0, var996=java.util.Set, var422=java.util.Collections, var204=$r11}
; {r0=var1300, null_type=var3076, org.apache.dubbo.common.utils.StringUtils=var2727, $z0=var2285, java.util.Set=var996, java.util.Collections=var422, $r11=var204}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $r1 = new java.util.TreeSet;	$r11 = staticinvoke <java.util.Collections: java.util.Set emptySet()>();	goto [?= return $r11];	return $r11
;block_num 3