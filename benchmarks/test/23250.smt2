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

(declare-sort var1520 0)
(declare-sort var2622 0)
(declare-sort var185 0)
(declare-sort var1349 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2622-init () var2622)
(declare-fun <init>/358169345 (var2622) void)
(declare-fun var185-init () var185)
(declare-fun <init>/980347192 (var185 var1349 Bool) void)
(declare-fun cast-from-var2622-to-var1349 (var2622) var1349)
(declare-fun printStackTrace/652371045 (var1520 var185) void)
(declare-fun getBuffer/-1377036288 (var2622) String)
(define-fun toString/-222306083 ((s String)) String s)
(declare-const null-var1520 var1520)
(declare-const var400 var1520) ; Statement: r2 := @parameter0: java.lang.Throwable 
(assert (not (= var400 null-var1520)))
(define-const var2958 var2622 var2622-init) ; Statement: $r0 = new java.io.StringWriter 
(assert true)
;(assert (<init>/358169345 var2958)) ; Statement: specialinvoke $r0.<java.io.StringWriter: void <init>()>() 

(declare-const var2958!1 var2622)
(define-const var1501 var185 var185-init) ; Statement: $r1 = new java.io.PrintWriter 
(assert true)
;(assert (<init>/980347192 var1501 (cast-from-var2622-to-var1349 var2958!1) (ite (= 1 1) true false))) ; Statement: specialinvoke $r1.<java.io.PrintWriter: void <init>(java.io.Writer,boolean)>($r0, 1) 

(declare-const var1501!1 var185)
(declare-const var2958!2 var2622)
(declare-const var1934 Int)
(assert true)
;(assert (printStackTrace/652371045 var400 var1501!1)) ; Statement: virtualinvoke r2.<java.lang.Throwable: void printStackTrace(java.io.PrintWriter)>($r1) 

(declare-const var400!1 var1520)
(declare-const var1501!2 var185)
(assert true)
(define-const var540 String (getBuffer/-1377036288 var2958!2)) ; Statement: $r3 = virtualinvoke $r0.<java.io.StringWriter: java.lang.StringBuffer getBuffer()>() 
(assert true)
(define-const var1857 String (toString/-222306083 var540)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuffer: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {var2622-init=([], java.io.StringWriter), <init>/358169345=([java.io.StringWriter], void), var185-init=([], java.io.PrintWriter), <init>/980347192=([java.io.PrintWriter, java.io.Writer, boolean], void), cast-from-var2622-to-var1349=([java.io.StringWriter], java.io.Writer), printStackTrace/652371045=([java.lang.Throwable, java.io.PrintWriter], void), getBuffer/-1377036288=([java.io.StringWriter], java.lang.StringBuffer), toString/-222306083=([java.lang.StringBuffer], java.lang.String)}
; {var1520=java.lang.Throwable, var400=r2, var2622=java.io.StringWriter, var2958=$r0, var185=java.io.PrintWriter, var1501=$r1, var1349=java.io.Writer, var1934=1, var540=$r3, var1857=$r4}
; {java.lang.Throwable=var1520, r2=var400, java.io.StringWriter=var2622, $r0=var2958, java.io.PrintWriter=var185, $r1=var1501, java.io.Writer=var1349, 1=var1934, $r3=var540, $r4=var1857}
;seq <java.lang.StringBuffer: java.lang.String toString()>
;cnt {"<java.lang.StringBuffer: java.lang.String toString()>": 1}
;stmts r2 := @parameter0: java.lang.Throwable;	$r0 = new java.io.StringWriter;	specialinvoke $r0.<java.io.StringWriter: void <init>()>();	$r1 = new java.io.PrintWriter;	specialinvoke $r1.<java.io.PrintWriter: void <init>(java.io.Writer,boolean)>($r0, 1);	virtualinvoke r2.<java.lang.Throwable: void printStackTrace(java.io.PrintWriter)>($r1);	$r3 = virtualinvoke $r0.<java.io.StringWriter: java.lang.StringBuffer getBuffer()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuffer: java.lang.String toString()>();	return $r4
;block_num 1