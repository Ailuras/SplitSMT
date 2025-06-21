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

(declare-sort var670 0)
(declare-sort var3839 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun var3839_matches/-236833593 (String String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-String String)
(declare-const var3220 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3220 null-String)))
(declare-const var2233 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2233 null-String)))
(define-const var3602 String var2233) ; Statement: r5 = r0 
(assert true)
(define-const var606 Bool (startsWith/-1785782452 var2233 "*")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("*") 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <java.util.regex.Pattern: boolean matches(java.lang.String,java.lang.CharSequence)>(r5, r1) 
(assert (= (ite var606 1 0) 0)) ; Cond: $z0 == 0 
(define-const var780 Bool (var3839_matches/-236833593 var3602 (cast-from-String-to-String var3220))) ; Statement: $z1 = staticinvoke <java.util.regex.Pattern: boolean matches(java.lang.String,java.lang.CharSequence)>(r5, r1) 
 ; Statement: return $z1 
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), var3839_matches/-236833593=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var3220=r1, var670=null_type, var2233=r0, var3602=r5, var606=$z0, var3839=java.util.regex.Pattern, var780=$z1}
; {r1=var3220, null_type=var670, r0=var2233, r5=var3602, $z0=var606, java.util.regex.Pattern=var3839, $z1=var780}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	r5 = r0;	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("*");	if $z0 == 0 goto $z1 = staticinvoke <java.util.regex.Pattern: boolean matches(java.lang.String,java.lang.CharSequence)>(r5, r1);	$z1 = staticinvoke <java.util.regex.Pattern: boolean matches(java.lang.String,java.lang.CharSequence)>(r5, r1);	return $z1
;block_num 2