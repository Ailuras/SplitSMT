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

(declare-sort var3488 0)
(declare-sort var2484 0)
(declare-sort var466 0)
(declare-sort var782 0)
(declare-sort var2529 0)
(declare-sort var3547 0)
(declare-sort var2468 0)
(declare-sort var3689 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3547!class ClassObject)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun cast-from-var466-to-var782 (var466) var782)
(declare-fun arr-var2529-init () (Array Int var2529))
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun cast-from-String-to-var2529 (String) var2529)
(declare-fun String_format/1339386452 (String (Array Int var2529)) String)
(declare-fun var2468-init () var2468)
(declare-fun <init>/-1566289705 (var2468 String var3689) void)
(declare-fun cast-from-var782-to-var3689 (var782) var3689)
(declare-const null-var3488 var3488)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2484 var2484)
(declare-const null-var466 var466)
(declare-const null-__Array__Int__var2529__ (Array Int var2529))
(declare-const var402 var3488) ; Statement: r5 := @this: org.antlr.v4.automata.ParserATNFactory 
(assert (not (= var402 null-var3488)))
(declare-const var3376 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var3376 null-ClassObject)))
(declare-const var1876 var2484) ; Statement: r15 := @parameter1: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var1876 null-var2484)))
(define-const var3901 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r1 = newarray (java.lang.Class)[0] 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3032 var466) ; Statement: $r14 := @caughtexception 
(assert (not (= var3032 null-var466)))
(define-const var2912 var782 (cast-from-var466-to-var782 var3032)) ; Statement: r17 = $r14 
 ; Statement: goto [?= $r18 = newarray (java.lang.Object)[2]] 
(assert true) ; Non Conditional
(define-const var341 (Array Int var2529) arr-var2529-init) ; Statement: $r18 = newarray (java.lang.Object)[2] 
(define-const var3436 ClassObject var3547!class) ; Statement: $r19 = class "Lorg/antlr/v4/runtime/atn/ATNState;" 
(assert true)
(define-const var1826 String (getName/-1958580599 var3436)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.Class: java.lang.String getName()>() 
(declare-const var341!1 (Array Int var2529))
(assert (not (= var341!1 null-__Array__Int__var2529__)))
(assert (= (select var341!1 0) (cast-from-String-to-var2529 var1826))) ; Statement: $r18[0] = $r20 
(assert true)
(define-const var973 String (getName/-1958580599 var3376)) ; Statement: $r21 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(declare-const var341!2 (Array Int var2529))
(assert (not (= var341!2 null-__Array__Int__var2529__)))
(assert (= (select var341!2 1) (cast-from-String-to-var2529 var973))) ; Statement: $r18[1] = $r21 
(define-const var3672 String (String_format/1339386452 "Could not create %s of type %s." var341!2)) ; Statement: $r22 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Could not create %s of type %s.", $r18) 
(define-const var306 var2468 var2468-init) ; Statement: $r24 = new java.lang.UnsupportedOperationException 
(assert true)
;(assert (<init>/-1566289705 var306 var3672 (cast-from-var782-to-var3689 var2912))) ; Statement: specialinvoke $r24.<java.lang.UnsupportedOperationException: void <init>(java.lang.String,java.lang.Throwable)>($r22, r17) 

(declare-const var306!1 var2468)
(declare-const var3672!1 String)
(declare-const var2912!1 var782)
 ; Statement: throw $r24 
(check-sat)
; {arr-ClassObject-init=([], java.lang.Class[]), cast-from-var466-to-var782=([java.lang.InstantiationException], java.lang.Exception), arr-var2529-init=([], java.lang.Object[]), getName/-1958580599=([java.lang.Class], java.lang.String), cast-from-String-to-var2529=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var2468-init=([], java.lang.UnsupportedOperationException), <init>/-1566289705=([java.lang.UnsupportedOperationException, java.lang.String, java.lang.Throwable], void), cast-from-var782-to-var3689=([java.lang.Exception], java.lang.Throwable)}
; {var3488=org.antlr.v4.automata.ParserATNFactory, var402=r5, var3376=r0, var2484=org.antlr.v4.tool.ast.GrammarAST, var1876=r15, var3901=$r1, var466=java.lang.InstantiationException, var3032=$r14, var782=java.lang.Exception, var2912=r17, var2529=java.lang.Object, var341=$r18, var3547=org.antlr.v4.runtime.atn.ATNState, var3436=$r19, var1826=$r20, var973=$r21, var3672=$r22, var2468=java.lang.UnsupportedOperationException, var306=$r24, var3689=java.lang.Throwable}
; {org.antlr.v4.automata.ParserATNFactory=var3488, r5=var402, r0=var3376, org.antlr.v4.tool.ast.GrammarAST=var2484, r15=var1876, $r1=var3901, java.lang.InstantiationException=var466, $r14=var3032, java.lang.Exception=var782, r17=var2912, java.lang.Object=var2529, $r18=var341, org.antlr.v4.runtime.atn.ATNState=var3547, $r19=var3436, $r20=var1826, $r21=var973, $r22=var3672, java.lang.UnsupportedOperationException=var2468, $r24=var306, java.lang.Throwable=var3689}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r5 := @this: org.antlr.v4.automata.ParserATNFactory;	r0 := @parameter0: java.lang.Class;	r15 := @parameter1: org.antlr.v4.tool.ast.GrammarAST;	$r1 = newarray (java.lang.Class)[0];	$r14 := @caughtexception;	r17 = $r14;	goto [?= $r18 = newarray (java.lang.Object)[2]];	$r18 = newarray (java.lang.Object)[2];	$r19 = class "Lorg/antlr/v4/runtime/atn/ATNState;";	$r20 = virtualinvoke $r19.<java.lang.Class: java.lang.String getName()>();	$r18[0] = $r20;	$r21 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$r18[1] = $r21;	$r22 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Could not create %s of type %s.", $r18);	$r24 = new java.lang.UnsupportedOperationException;	specialinvoke $r24.<java.lang.UnsupportedOperationException: void <init>(java.lang.String,java.lang.Throwable)>($r22, r17);	throw $r24
;block_num 3