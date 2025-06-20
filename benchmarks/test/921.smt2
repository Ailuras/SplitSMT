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

(declare-sort var378 0)
(declare-sort var155 0)
(declare-sort var3410 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var155-init () var155)
(declare-fun <init>/2146899862 (var155) void)
(declare-fun getEngineByName/1394373575 (var155 String) var3410)
(declare-const null-String String)
(declare-const null-var3410 var3410)
(declare-const var3428 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3428 null-String)))
(declare-const var1029 String) ; Statement: r8 := @parameter1: java.lang.String 
(assert (not (= var1029 null-String)))
(define-const var2741 var155 var155-init) ; Statement: $r0 = new javax.script.ScriptEngineManager 
(assert true)
;(assert (<init>/2146899862 var2741)) ; Statement: specialinvoke $r0.<javax.script.ScriptEngineManager: void <init>()>() 

(declare-const var2741!1 var155)
(assert true)
(define-const var540 var3410 (getEngineByName/1394373575 var2741!1 var3428)) ; Statement: r2 = virtualinvoke $r0.<javax.script.ScriptEngineManager: javax.script.ScriptEngine getEngineByName(java.lang.String)>(r1) 
 ; Statement: if r2 != null goto return r2 
(assert (not (= var540 null-var3410))) ; Cond: r2 != null 
 ; Statement: return r2 
(check-sat)
; {var155-init=([], javax.script.ScriptEngineManager), <init>/2146899862=([javax.script.ScriptEngineManager], void), getEngineByName/1394373575=([javax.script.ScriptEngineManager, java.lang.String], javax.script.ScriptEngine)}
; {var3428=r1, var378=null_type, var1029=r8, var155=javax.script.ScriptEngineManager, var2741=$r0, var3410=javax.script.ScriptEngine, var540=r2}
; {r1=var3428, null_type=var378, r8=var1029, javax.script.ScriptEngineManager=var155, $r0=var2741, javax.script.ScriptEngine=var3410, r2=var540}
;seq 
;cnt {}
;stmts r1 := @parameter0: java.lang.String;	r8 := @parameter1: java.lang.String;	$r0 = new javax.script.ScriptEngineManager;	specialinvoke $r0.<javax.script.ScriptEngineManager: void <init>()>();	r2 = virtualinvoke $r0.<javax.script.ScriptEngineManager: javax.script.ScriptEngine getEngineByName(java.lang.String)>(r1);	if r2 != null goto return r2;	return r2
;block_num 2