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

(declare-sort var34 0)
(declare-sort var2088 0)
(declare-sort var900 0)
(declare-sort var3365 0)
(declare-sort var1113 0)
(declare-sort var3171 0)
(declare-sort var3849 0)
(declare-sort var2864 0)
(declare-sort var2511 0)
(declare-sort var1053 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun makeObjectBankFromString/-675969717 (var34 String var900) var3365)
(declare-fun var1113-init () var1113)
(declare-fun <init>/358169345 (var1113) void)
(declare-fun var3171-init () var3171)
(declare-fun <init>/-1864438596 (var3171 var3849) void)
(declare-fun cast-from-var1113-to-var3849 (var1113) var3849)
(declare-fun iterator/1890858564 (var3365) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun close/2116439267 (var3171) void)
(declare-fun toString/138175384 (var1113) String)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var2511_asList/1779083644 ((Array Int var1053)) var2864)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1053__ ((Array Int String)) (Array Int var1053))
(declare-const null-var34 var34)
(declare-const null-String String)
(declare-const null-var900 var900)
(declare-const var2887 var34) ; Statement: r0 := @this: edu.stanford.nlp.ie.AbstractSequenceClassifier 
(assert (not (= var2887 null-var34)))
(declare-const var817 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var817 null-String)))
(declare-const var2002 var900) ; Statement: r2 := @parameter1: edu.stanford.nlp.sequences.DocumentReaderAndWriter 
(assert (not (= var2002 null-var900)))
(assert true)
(define-const var329 var3365 (makeObjectBankFromString/-675969717 var2887 var817 var2002)) ; Statement: r3 = virtualinvoke r0.<edu.stanford.nlp.ie.AbstractSequenceClassifier: edu.stanford.nlp.objectbank.ObjectBank makeObjectBankFromString(java.lang.String,edu.stanford.nlp.sequences.DocumentReaderAndWriter)>(r1, r2) 
(define-const var523 var1113 var1113-init) ; Statement: $r4 = new java.io.StringWriter 
(assert true)
;(assert (<init>/358169345 var523)) ; Statement: specialinvoke $r4.<java.io.StringWriter: void <init>()>() 

(declare-const var523!1 var1113)
(define-const var799 var3171 var3171-init) ; Statement: $r5 = new java.io.PrintWriter 
(assert true)
;(assert (<init>/-1864438596 var799 (cast-from-var1113-to-var3849 var523!1))) ; Statement: specialinvoke $r5.<java.io.PrintWriter: void <init>(java.io.Writer)>($r4) 

(declare-const var799!1 var3171)
(declare-const var523!2 var1113)
(assert true)
(define-const var2311 Iterator (iterator/1890858564 var329)) ; Statement: r11 = virtualinvoke r3.<edu.stanford.nlp.objectbank.ObjectBank: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var1190 Bool (Iterator_hasNext/-1669924200 var2311)) ; Statement: $z0 = interfaceinvoke r11.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto virtualinvoke $r5.<java.io.PrintWriter: void close()>() 
(assert (= (ite var1190 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (close/2116439267 var799!1)) ; Statement: virtualinvoke $r5.<java.io.PrintWriter: void close()>() 

(declare-const var799!2 var3171)
(assert true)
(define-const var3624 String (toString/138175384 var523!2)) ; Statement: r12 = virtualinvoke $r4.<java.io.StringWriter: java.lang.String toString()>() 
(assert true)
(define-const var1429 Int (length/-134980193 var3624)) ; Statement: $i0 = virtualinvoke r12.<java.lang.String: int length()>() 
 ; Statement: if $i0 != 0 goto $r6 = virtualinvoke r12.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s") 
(assert (not (= var1429 0))) ; Cond: $i0 != 0 
; split operation: var910 = var3624.split("\u005cs") ; Statement: $r6 = virtualinvoke r12.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s") 
(define-const var1245 var2864 (var2511_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var1053__ var910))) ; Statement: $r7 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r6) 
 ; Statement: return $r7 
(check-sat)
; {makeObjectBankFromString/-675969717=([edu.stanford.nlp.ie.AbstractSequenceClassifier, java.lang.String, edu.stanford.nlp.sequences.DocumentReaderAndWriter], edu.stanford.nlp.objectbank.ObjectBank), var1113-init=([], java.io.StringWriter), <init>/358169345=([java.io.StringWriter], void), var3171-init=([], java.io.PrintWriter), <init>/-1864438596=([java.io.PrintWriter, java.io.Writer], void), cast-from-var1113-to-var3849=([java.io.StringWriter], java.io.Writer), iterator/1890858564=([edu.stanford.nlp.objectbank.ObjectBank], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), close/2116439267=([java.io.PrintWriter], void), toString/138175384=([java.io.StringWriter], java.lang.String), length/-134980193=([java.lang.String], int), var2511_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var1053__=([java.lang.String[]], java.lang.Object[])}
; {var34=edu.stanford.nlp.ie.AbstractSequenceClassifier, var2887=r0, var817=r1, var2088=null_type, var900=edu.stanford.nlp.sequences.DocumentReaderAndWriter, var2002=r2, var3365=edu.stanford.nlp.objectbank.ObjectBank, var329=r3, var1113=java.io.StringWriter, var523=$r4, var3171=java.io.PrintWriter, var799=$r5, var3849=java.io.Writer, var2311=r11, var1190=$z0, var3624=r12, var1429=$i0, var910=$r6, var2864=java.util.List, var2511=java.util.Arrays, var1053=java.lang.Object, var1245=$r7}
; {edu.stanford.nlp.ie.AbstractSequenceClassifier=var34, r0=var2887, r1=var817, null_type=var2088, edu.stanford.nlp.sequences.DocumentReaderAndWriter=var900, r2=var2002, edu.stanford.nlp.objectbank.ObjectBank=var3365, r3=var329, java.io.StringWriter=var1113, $r4=var523, java.io.PrintWriter=var3171, $r5=var799, java.io.Writer=var3849, r11=var2311, $z0=var1190, r12=var3624, $i0=var1429, $r6=var910, java.util.List=var2864, java.util.Arrays=var2511, java.lang.Object=var1053, $r7=var1245}
;seq <java.io.StringWriter: java.lang.String toString()>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: edu.stanford.nlp.ie.AbstractSequenceClassifier;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: edu.stanford.nlp.sequences.DocumentReaderAndWriter;	r3 = virtualinvoke r0.<edu.stanford.nlp.ie.AbstractSequenceClassifier: edu.stanford.nlp.objectbank.ObjectBank makeObjectBankFromString(java.lang.String,edu.stanford.nlp.sequences.DocumentReaderAndWriter)>(r1, r2);	$r4 = new java.io.StringWriter;	specialinvoke $r4.<java.io.StringWriter: void <init>()>();	$r5 = new java.io.PrintWriter;	specialinvoke $r5.<java.io.PrintWriter: void <init>(java.io.Writer)>($r4);	r11 = virtualinvoke r3.<edu.stanford.nlp.objectbank.ObjectBank: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r11.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto virtualinvoke $r5.<java.io.PrintWriter: void close()>();	virtualinvoke $r5.<java.io.PrintWriter: void close()>();	r12 = virtualinvoke $r4.<java.io.StringWriter: java.lang.String toString()>();	$i0 = virtualinvoke r12.<java.lang.String: int length()>();	if $i0 != 0 goto $r6 = virtualinvoke r12.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s");	$r6 = virtualinvoke r12.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s");	$r7 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r6);	return $r7
;block_num 4