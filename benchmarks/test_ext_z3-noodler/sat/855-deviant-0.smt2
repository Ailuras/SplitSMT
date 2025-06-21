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

(declare-sort var1694 0)
(declare-sort var1578 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(declare-fun var1578_toUpperCase/1913344327 (Int) Int)
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun cast-from-Int-to-String (Int) String)
(declare-const null-String String)
(declare-const var1779 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1779 null-String)))
(assert (not (and true (and (> (str.len var1779) 0) (<= 0 0)))))
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), var1578_toUpperCase/1913344327=([char], char), substring/850833817=([java.lang.String, int], java.lang.String), cast-from-Int-to-String=([char], java.lang.String)}
; {var1779=r0, var1694=null_type, var2337=$c0, var1578=java.lang.Character, var836=$c1, var2005=$r1, var3979=$r2}
; {r0=var1779, null_type=var1694, $c0=var2337, java.lang.Character=var1578, $c1=var836, $r1=var2005, $r2=var3979}
;seq <java.lang.String: char charAt(int)>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);	$c1 = staticinvoke <java.lang.Character: char toUpperCase(char)>($c0);	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>(1);	$r2 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (char,java.lang.String)>($c1, $r1) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001\u0001");	return $r2
;block_num 1