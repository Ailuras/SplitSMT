(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3578 0)
(declare-sort var1700 0)
(declare-sort var2461 0)
(declare-sort var1876 0)
(declare-sort var2201 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1876-init () var1876)
(declare-fun <init>/358169345 (var1876) void)
(declare-fun omitComments/-1276310728 (var3578) Bool)
(declare-fun store/-1111572071 (var2201 var1700 String) void)
(declare-fun cast-from-var3578-to-var2201 (var3578) var2201)
(declare-fun cast-from-var1876-to-var1700 (var1876) var1700)
(declare-fun toString/138175384 (var1876) String)
(declare-const null-var3578 var3578)
(declare-const null-var1700 var1700)
(declare-const null-String String)
(declare-const var3578-EOL String)
(declare-const var3651 var3578) ; Statement: r1 := @this: org.springframework.core.SortedProperties 
(assert (not (= var3651 null-var3578)))
(declare-const var1157 var1700) ; Statement: r5 := @parameter0: java.io.Writer 
(assert (not (= var1157 null-var1700)))
(declare-const var261 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var261 null-String)))
(define-const var1272 var1876 var1876-init) ; Statement: $r0 = new java.io.StringWriter 
(assert true)
;(assert (<init>/358169345 var1272)) ; Statement: specialinvoke $r0.<java.io.StringWriter: void <init>()>() 

(declare-const var1272!1 var1876)
(define-const var91 Bool (omitComments/-1276310728 var3651)) ; Statement: $z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments> 
 ; Statement: if $z0 == 0 goto $r10 = r2 
(assert (= (ite var91 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2739 String var261) ; Statement: $r10 = r2 
(assert true) ; Non Conditional
(assert true)
;(assert (store/-1111572071 (cast-from-var3578-to-var2201 var3651) (cast-from-var1876-to-var1700 var1272!1) var2739)) ; Statement: specialinvoke r1.<java.util.Properties: void store(java.io.Writer,java.lang.String)>($r0, $r10) 

(declare-const var3651!1 var3578)
(declare-const var1272!2 var1876)
(declare-const var2739!1 String)
(assert true)
(define-const var2756 String (toString/138175384 var1272!2)) ; Statement: $r8 = virtualinvoke $r0.<java.io.StringWriter: java.lang.String toString()>() 
(define-const var2601 String var3578-EOL) ; Statement: $r3 = <org.springframework.core.SortedProperties: java.lang.String EOL> 
; split operation: var360 = var2756.split(var2601) ; Statement: $r9 = virtualinvoke $r8.<java.lang.String: java.lang.String[] split(java.lang.String)>($r3) 
(define-const var2597 Int (get_split_length var2756 var2601 -1)) ; Statement: $i0 = lengthof $r9 
(define-const var3729 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return 
(assert (>= var3729 var2597)) ; Cond: i1 >= $i0 
 ; Statement: return 
(check-sat)
; {var1876-init=([], java.io.StringWriter), <init>/358169345=([java.io.StringWriter], void), omitComments/-1276310728=([org.springframework.core.SortedProperties], boolean), store/-1111572071=([java.util.Properties, java.io.Writer, java.lang.String], void), cast-from-var3578-to-var2201=([org.springframework.core.SortedProperties], java.util.Properties), cast-from-var1876-to-var1700=([java.io.StringWriter], java.io.Writer), toString/138175384=([java.io.StringWriter], java.lang.String)}
; {var3578=org.springframework.core.SortedProperties, var3651=r1, var1700=java.io.Writer, var1157=r5, var261=r2, var2461=null_type, var1876=java.io.StringWriter, var1272=$r0, var91=$z0, var2739=$r10, var2201=java.util.Properties, var2756=$r8, var2601=$r3, var360=$r9, var2597=$i0, var3729=i1}
; {org.springframework.core.SortedProperties=var3578, r1=var3651, java.io.Writer=var1700, r5=var1157, r2=var261, null_type=var2461, java.io.StringWriter=var1876, $r0=var1272, $z0=var91, $r10=var2739, java.util.Properties=var2201, $r8=var2756, $r3=var2601, $r9=var360, $i0=var2597, i1=var3729}
;seq <java.io.StringWriter: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @this: org.springframework.core.SortedProperties;	r5 := @parameter0: java.io.Writer;	r2 := @parameter1: java.lang.String;	$r0 = new java.io.StringWriter;	specialinvoke $r0.<java.io.StringWriter: void <init>()>();	$z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments>;	if $z0 == 0 goto $r10 = r2;	$r10 = r2;	specialinvoke r1.<java.util.Properties: void store(java.io.Writer,java.lang.String)>($r0, $r10);	$r8 = virtualinvoke $r0.<java.io.StringWriter: java.lang.String toString()>();	$r3 = <org.springframework.core.SortedProperties: java.lang.String EOL>;	$r9 = virtualinvoke $r8.<java.lang.String: java.lang.String[] split(java.lang.String)>($r3);	$i0 = lengthof $r9;	i1 = 0;	if i1 >= $i0 goto return;	return
;block_num 5