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

(declare-sort var1556 0)
(declare-sort var3598 0)
(declare-sort var2879 0)
(declare-sort var1260 0)
(declare-sort var2373 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1260-init () var1260)
(declare-fun <init>/358169345 (var1260) void)
(declare-fun omitComments/-1276310728 (var1556) Bool)
(declare-fun store/-1111572071 (var2373 var3598 String) void)
(declare-fun cast-from-var1556-to-var2373 (var1556) var2373)
(declare-fun cast-from-var1260-to-var3598 (var1260) var3598)
(declare-fun toString/138175384 (var1260) String)
(declare-const null-var1556 var1556)
(declare-const null-var3598 var3598)
(declare-const null-String String)
(declare-const var1556-EOL String)
(declare-const var3293 var1556) ; Statement: r1 := @this: org.springframework.core.SortedProperties 
(assert (not (= var3293 null-var1556)))
(declare-const var1185 var3598) ; Statement: r5 := @parameter0: java.io.Writer 
(assert (not (= var1185 null-var3598)))
(declare-const var2955 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2955 null-String)))
(define-const var3310 var1260 var1260-init) ; Statement: $r0 = new java.io.StringWriter 
(assert true)
;(assert (<init>/358169345 var3310)) ; Statement: specialinvoke $r0.<java.io.StringWriter: void <init>()>() 

(declare-const var3310!1 var1260)
(define-const var420 Bool (omitComments/-1276310728 var3293)) ; Statement: $z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments> 
 ; Statement: if $z0 == 0 goto $r10 = r2 
(assert (not (= (ite var420 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2177 String null-String) ; Statement: $r10 = null 
 ; Statement: goto [?= specialinvoke r1.<java.util.Properties: void store(java.io.Writer,java.lang.String)>($r0, $r10)] 
(assert true) ; Non Conditional
(assert true)
;(assert (store/-1111572071 (cast-from-var1556-to-var2373 var3293) (cast-from-var1260-to-var3598 var3310!1) var2177)) ; Statement: specialinvoke r1.<java.util.Properties: void store(java.io.Writer,java.lang.String)>($r0, $r10) 

(declare-const var3293!1 var1556)
(declare-const var3310!2 var1260)
(declare-const var2177!1 String)
(assert true)
(define-const var1735 String (toString/138175384 var3310!2)) ; Statement: $r8 = virtualinvoke $r0.<java.io.StringWriter: java.lang.String toString()>() 
(define-const var3952 String var1556-EOL) ; Statement: $r3 = <org.springframework.core.SortedProperties: java.lang.String EOL> 
; split operation: var3654 = var1735.split(var3952) ; Statement: $r9 = virtualinvoke $r8.<java.lang.String: java.lang.String[] split(java.lang.String)>($r3) 
(define-const var811 Int (get_split_length var1735 var3952 -1)) ; Statement: $i0 = lengthof $r9 
; (assert (= var811 (get_split_length var1735 var3952 -1)))
(define-const var2546 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return 
(assert (>= var2546 var811)) ; Cond: i1 >= $i0 
 ; Statement: return 
(check-sat)
; {var1260-init=([], java.io.StringWriter), <init>/358169345=([java.io.StringWriter], void), omitComments/-1276310728=([org.springframework.core.SortedProperties], boolean), store/-1111572071=([java.util.Properties, java.io.Writer, java.lang.String], void), cast-from-var1556-to-var2373=([org.springframework.core.SortedProperties], java.util.Properties), cast-from-var1260-to-var3598=([java.io.StringWriter], java.io.Writer), toString/138175384=([java.io.StringWriter], java.lang.String)}
; {var1556=org.springframework.core.SortedProperties, var3293=r1, var3598=java.io.Writer, var1185=r5, var2955=r2, var2879=null_type, var1260=java.io.StringWriter, var3310=$r0, var420=$z0, var2177=$r10, var2373=java.util.Properties, var1735=$r8, var3952=$r3, var3654=$r9, var811=$i0, var2546=i1}
; {org.springframework.core.SortedProperties=var1556, r1=var3293, java.io.Writer=var3598, r5=var1185, r2=var2955, null_type=var2879, java.io.StringWriter=var1260, $r0=var3310, $z0=var420, $r10=var2177, java.util.Properties=var2373, $r8=var1735, $r3=var3952, $r9=var3654, $i0=var811, i1=var2546}
;seq <java.io.StringWriter: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @this: org.springframework.core.SortedProperties;	r5 := @parameter0: java.io.Writer;	r2 := @parameter1: java.lang.String;	$r0 = new java.io.StringWriter;	specialinvoke $r0.<java.io.StringWriter: void <init>()>();	$z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments>;	if $z0 == 0 goto $r10 = r2;	$r10 = null;	goto [?= specialinvoke r1.<java.util.Properties: void store(java.io.Writer,java.lang.String)>($r0, $r10)];	specialinvoke r1.<java.util.Properties: void store(java.io.Writer,java.lang.String)>($r0, $r10);	$r8 = virtualinvoke $r0.<java.io.StringWriter: java.lang.String toString()>();	$r3 = <org.springframework.core.SortedProperties: java.lang.String EOL>;	$r9 = virtualinvoke $r8.<java.lang.String: java.lang.String[] split(java.lang.String)>($r3);	$i0 = lengthof $r9;	i1 = 0;	if i1 >= $i0 goto return;	return
;block_num 5