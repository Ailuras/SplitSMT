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

(declare-sort var3934 0)
(declare-sort var1020 0)
(declare-sort var2210 0)
(declare-sort var2864 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1020-init () var1020)
(declare-fun <init>/2146899862 (var1020) void)
(declare-fun getEngineByName/1394373575 (var1020 String) var2210)
(declare-fun var2864-init () var2864)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var2864 String) void)
(declare-const null-String String)
(declare-const null-var2210 var2210)
(declare-const var794 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var794 null-String)))
(declare-const var823 String) ; Statement: r8 := @parameter1: java.lang.String 
(assert (not (= var823 null-String)))
(define-const var2648 var1020 var1020-init) ; Statement: $r0 = new javax.script.ScriptEngineManager 
(assert true)
;(assert (<init>/2146899862 var2648)) ; Statement: specialinvoke $r0.<javax.script.ScriptEngineManager: void <init>()>() 

(declare-const var2648!1 var1020)
(assert true)
(define-const var556 var2210 (getEngineByName/1394373575 var2648!1 var794)) ; Statement: r2 = virtualinvoke $r0.<javax.script.ScriptEngineManager: javax.script.ScriptEngine getEngineByName(java.lang.String)>(r1) 
 ; Statement: if r2 != null goto return r2 
(assert (not (not (= var556 null-var2210)))) ; Negate: Cond: r2 != null  
(define-const var2188 var2864 var2864-init) ; Statement: $r3 = new java.lang.IllegalStateException 
(define-const var3575 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3575)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3575!1 String)
(assert (= var3575!1 ""))
(assert true)
(define-const var3714 String (append/672562846 var3575!1 "unsupported route engine type: ")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("unsupported route engine type: ") 
(declare-const var3575!2 String)
(assert (= var3575!2 (str.++ var3575!1 "unsupported route engine type: ")))
(assert true)
(define-const var2703 String (append/672562846 var3714 var794)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var3714!1 String)
(assert (= var3714!1 (str.++ var3714 var794)))
(assert true)
(define-const var1889 String (toString/-2075883882 var2703)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var2188 var1889)) ; Statement: specialinvoke $r3.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r7) 

(declare-const var2188!1 var2864)
(declare-const var1889!1 String)
 ; Statement: throw $r3 
(check-sat)
; {var1020-init=([], javax.script.ScriptEngineManager), <init>/2146899862=([javax.script.ScriptEngineManager], void), getEngineByName/1394373575=([javax.script.ScriptEngineManager, java.lang.String], javax.script.ScriptEngine), var2864-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var794=r1, var3934=null_type, var823=r8, var1020=javax.script.ScriptEngineManager, var2648=$r0, var2210=javax.script.ScriptEngine, var556=r2, var2864=java.lang.IllegalStateException, var2188=$r3, var3575=$r4, var3714=$r5, var2703=$r6, var1889=$r7}
; {r1=var794, null_type=var3934, r8=var823, javax.script.ScriptEngineManager=var1020, $r0=var2648, javax.script.ScriptEngine=var2210, r2=var556, java.lang.IllegalStateException=var2864, $r3=var2188, $r4=var3575, $r5=var3714, $r6=var2703, $r7=var1889}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.String;	r8 := @parameter1: java.lang.String;	$r0 = new javax.script.ScriptEngineManager;	specialinvoke $r0.<javax.script.ScriptEngineManager: void <init>()>();	r2 = virtualinvoke $r0.<javax.script.ScriptEngineManager: javax.script.ScriptEngine getEngineByName(java.lang.String)>(r1);	if r2 != null goto return r2;	$r3 = new java.lang.IllegalStateException;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("unsupported route engine type: ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r3.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r7);	throw $r3
;block_num 2