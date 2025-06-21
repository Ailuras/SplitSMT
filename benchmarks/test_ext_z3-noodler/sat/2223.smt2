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

(declare-sort var2220 0)
(declare-sort var2864 0)
(declare-sort var1773 0)
(declare-sort var3836 0)
(declare-sort var1505 0)
(declare-sort var1562 0)
(declare-sort var1923 0)
(declare-sort var3244 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1562!class ClassObject)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun cast-from-var1773-to-var3836 (var1773) var3836)
(declare-fun arr-var1505-init () (Array Int var1505))
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun cast-from-String-to-var1505 (String) var1505)
(declare-fun String_format/1339386452 (String (Array Int var1505)) String)
(declare-fun var1923-init () var1923)
(declare-fun <init>/-1566289705 (var1923 String var3244) void)
(declare-fun cast-from-var3836-to-var3244 (var3836) var3244)
(declare-const null-var2220 var2220)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2864 var2864)
(declare-const null-var1773 var1773)
(declare-const null-__Array__Int__var1505__ (Array Int var1505))
(declare-const var1361 var2220) ; Statement: r5 := @this: org.antlr.v4.automata.ParserATNFactory 
(assert (not (= var1361 null-var2220)))
(declare-const var2617 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var2617 null-ClassObject)))
(declare-const var3073 var2864) ; Statement: r15 := @parameter1: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var3073 null-var2864)))
(define-const var3393 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r1 = newarray (java.lang.Class)[0] 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2842 var1773) ; Statement: $r13 := @caughtexception 
(assert (not (= var2842 null-var1773)))
(define-const var1707 var3836 (cast-from-var1773-to-var3836 var2842)) ; Statement: r17 = $r13 
 ; Statement: goto [?= $r18 = newarray (java.lang.Object)[2]] 
(assert true) ; Non Conditional
(define-const var2730 (Array Int var1505) arr-var1505-init) ; Statement: $r18 = newarray (java.lang.Object)[2] 
(define-const var1635 ClassObject var1562!class) ; Statement: $r19 = class "Lorg/antlr/v4/runtime/atn/ATNState;" 
(assert true)
(define-const var981 String (getName/-1958580599 var1635)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.Class: java.lang.String getName()>() 
(declare-const var2730!1 (Array Int var1505))
(assert (not (= var2730!1 null-__Array__Int__var1505__)))
(assert (= (select var2730!1 0) (cast-from-String-to-var1505 var981))) ; Statement: $r18[0] = $r20 
(assert true)
(define-const var1840 String (getName/-1958580599 var2617)) ; Statement: $r21 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(declare-const var2730!2 (Array Int var1505))
(assert (not (= var2730!2 null-__Array__Int__var1505__)))
(assert (= (select var2730!2 1) (cast-from-String-to-var1505 var1840))) ; Statement: $r18[1] = $r21 
(define-const var3394 String (String_format/1339386452 "Could not create %s of type %s." var2730!2)) ; Statement: $r22 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Could not create %s of type %s.", $r18) 
(define-const var832 var1923 var1923-init) ; Statement: $r24 = new java.lang.UnsupportedOperationException 
(assert true)
;(assert (<init>/-1566289705 var832 var3394 (cast-from-var3836-to-var3244 var1707))) ; Statement: specialinvoke $r24.<java.lang.UnsupportedOperationException: void <init>(java.lang.String,java.lang.Throwable)>($r22, r17) 

(declare-const var832!1 var1923)
(declare-const var3394!1 String)
(declare-const var1707!1 var3836)
 ; Statement: throw $r24 
(check-sat)
; {arr-ClassObject-init=([], java.lang.Class[]), cast-from-var1773-to-var3836=([java.lang.IllegalAccessException], java.lang.Exception), arr-var1505-init=([], java.lang.Object[]), getName/-1958580599=([java.lang.Class], java.lang.String), cast-from-String-to-var1505=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var1923-init=([], java.lang.UnsupportedOperationException), <init>/-1566289705=([java.lang.UnsupportedOperationException, java.lang.String, java.lang.Throwable], void), cast-from-var3836-to-var3244=([java.lang.Exception], java.lang.Throwable)}
; {var2220=org.antlr.v4.automata.ParserATNFactory, var1361=r5, var2617=r0, var2864=org.antlr.v4.tool.ast.GrammarAST, var3073=r15, var3393=$r1, var1773=java.lang.IllegalAccessException, var2842=$r13, var3836=java.lang.Exception, var1707=r17, var1505=java.lang.Object, var2730=$r18, var1562=org.antlr.v4.runtime.atn.ATNState, var1635=$r19, var981=$r20, var1840=$r21, var3394=$r22, var1923=java.lang.UnsupportedOperationException, var832=$r24, var3244=java.lang.Throwable}
; {org.antlr.v4.automata.ParserATNFactory=var2220, r5=var1361, r0=var2617, org.antlr.v4.tool.ast.GrammarAST=var2864, r15=var3073, $r1=var3393, java.lang.IllegalAccessException=var1773, $r13=var2842, java.lang.Exception=var3836, r17=var1707, java.lang.Object=var1505, $r18=var2730, org.antlr.v4.runtime.atn.ATNState=var1562, $r19=var1635, $r20=var981, $r21=var1840, $r22=var3394, java.lang.UnsupportedOperationException=var1923, $r24=var832, java.lang.Throwable=var3244}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r5 := @this: org.antlr.v4.automata.ParserATNFactory;	r0 := @parameter0: java.lang.Class;	r15 := @parameter1: org.antlr.v4.tool.ast.GrammarAST;	$r1 = newarray (java.lang.Class)[0];	$r13 := @caughtexception;	r17 = $r13;	goto [?= $r18 = newarray (java.lang.Object)[2]];	$r18 = newarray (java.lang.Object)[2];	$r19 = class "Lorg/antlr/v4/runtime/atn/ATNState;";	$r20 = virtualinvoke $r19.<java.lang.Class: java.lang.String getName()>();	$r18[0] = $r20;	$r21 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$r18[1] = $r21;	$r22 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Could not create %s of type %s.", $r18);	$r24 = new java.lang.UnsupportedOperationException;	specialinvoke $r24.<java.lang.UnsupportedOperationException: void <init>(java.lang.String,java.lang.Throwable)>($r22, r17);	throw $r24
;block_num 3