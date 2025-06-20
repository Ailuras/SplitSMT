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

(declare-sort var217 0)
(declare-sort var871 0)
(declare-sort var3173 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun var871_currentThread/-1037784612 () var871)
(declare-fun getContextClassLoader/1719676180 (var871) var3173)
(declare-fun ClassObject_forName/696536127 (String Bool var3173) ClassObject)
(declare-const null-String String)
(declare-const var1783 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1783 null-String)))
(assert true)
(define-const var3854 Bool (endsWith/985337093 var1783 "[]")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean endsWith(java.lang.String)>("[]") 
 ; Statement: if $z0 == 0 goto $r9 = r0 
(assert (= (ite var3854 1 0) 0)) ; Cond: $z0 == 0 
(define-const var468 String var1783) ; Statement: $r9 = r0 
(assert true) ; Non Conditional
(define-const var3762 var871 var871_currentThread/-1037784612) ; Statement: $r1 = staticinvoke <java.lang.Thread: java.lang.Thread currentThread()>() 
(assert true)
(define-const var2403 var3173 (getContextClassLoader/1719676180 var3762)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.Thread: java.lang.ClassLoader getContextClassLoader()>() 
(define-const var2520 ClassObject (ClassObject_forName/696536127 var468 (ite (= 1 1) true false) var2403)) ; Statement: $r3 = staticinvoke <java.lang.Class: java.lang.Class forName(java.lang.String,boolean,java.lang.ClassLoader)>($r9, 1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {endsWith/985337093=([java.lang.String, java.lang.String], boolean), var871_currentThread/-1037784612=([], java.lang.Thread), getContextClassLoader/1719676180=([java.lang.Thread], java.lang.ClassLoader), ClassObject_forName/696536127=([java.lang.String, boolean, java.lang.ClassLoader], java.lang.Class)}
; {var1783=r0, var217=null_type, var3854=$z0, var468=$r9, var871=java.lang.Thread, var3762=$r1, var3173=java.lang.ClassLoader, var2403=$r2, var2520=$r3}
; {r0=var1783, null_type=var217, $z0=var3854, $r9=var468, java.lang.Thread=var871, $r1=var3762, java.lang.ClassLoader=var3173, $r2=var2403, $r3=var2520}
;seq <java.lang.String: boolean endsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean endsWith(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean endsWith(java.lang.String)>("[]");	if $z0 == 0 goto $r9 = r0;	$r9 = r0;	$r1 = staticinvoke <java.lang.Thread: java.lang.Thread currentThread()>();	$r2 = virtualinvoke $r1.<java.lang.Thread: java.lang.ClassLoader getContextClassLoader()>();	$r3 = staticinvoke <java.lang.Class: java.lang.Class forName(java.lang.String,boolean,java.lang.ClassLoader)>($r9, 1, $r2);	return $r3
;block_num 3