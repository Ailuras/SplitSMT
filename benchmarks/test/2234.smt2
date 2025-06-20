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

(declare-sort var973 0)
(declare-sort var1436 0)
(declare-sort var3907 0)
(declare-sort var2486 0)
(declare-sort var313 0)
(declare-sort var2971 0)
(declare-sort var509 0)
(declare-sort var914 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2971!class ClassObject)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun cast-from-var3907-to-var2486 (var3907) var2486)
(declare-fun arr-var313-init () (Array Int var313))
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun cast-from-String-to-var313 (String) var313)
(declare-fun String_format/1339386452 (String (Array Int var313)) String)
(declare-fun var509-init () var509)
(declare-fun <init>/-1566289705 (var509 String var914) void)
(declare-fun cast-from-var2486-to-var914 (var2486) var914)
(declare-const null-var973 var973)
(declare-const null-ClassObject ClassObject)
(declare-const null-var1436 var1436)
(declare-const null-var3907 var3907)
(declare-const null-__Array__Int__var313__ (Array Int var313))
(declare-const var2841 var973) ; Statement: r5 := @this: org.antlr.v4.automata.ParserATNFactory 
(assert (not (= var2841 null-var973)))
(declare-const var2677 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var2677 null-ClassObject)))
(declare-const var2988 var1436) ; Statement: r15 := @parameter1: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var2988 null-var1436)))
(define-const var2363 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r1 = newarray (java.lang.Class)[0] 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3644 var3907) ; Statement: $r11 := @caughtexception 
(assert (not (= var3644 null-var3907)))
(define-const var380 var2486 (cast-from-var3907-to-var2486 var3644)) ; Statement: r17 = $r11 
 ; Statement: goto [?= $r18 = newarray (java.lang.Object)[2]] 
(assert true) ; Non Conditional
(define-const var3974 (Array Int var313) arr-var313-init) ; Statement: $r18 = newarray (java.lang.Object)[2] 
(define-const var1699 ClassObject var2971!class) ; Statement: $r19 = class "Lorg/antlr/v4/runtime/atn/ATNState;" 
(assert true)
(define-const var3154 String (getName/-1958580599 var1699)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.Class: java.lang.String getName()>() 
(declare-const var3974!1 (Array Int var313))
(assert (not (= var3974!1 null-__Array__Int__var313__)))
(assert (= (select var3974!1 0) (cast-from-String-to-var313 var3154))) ; Statement: $r18[0] = $r20 
(assert true)
(define-const var3390 String (getName/-1958580599 var2677)) ; Statement: $r21 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(declare-const var3974!2 (Array Int var313))
(assert (not (= var3974!2 null-__Array__Int__var313__)))
(assert (= (select var3974!2 1) (cast-from-String-to-var313 var3390))) ; Statement: $r18[1] = $r21 
(define-const var2543 String (String_format/1339386452 "Could not create %s of type %s." var3974!2)) ; Statement: $r22 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Could not create %s of type %s.", $r18) 
(define-const var2494 var509 var509-init) ; Statement: $r24 = new java.lang.UnsupportedOperationException 
(assert true)
;(assert (<init>/-1566289705 var2494 var2543 (cast-from-var2486-to-var914 var380))) ; Statement: specialinvoke $r24.<java.lang.UnsupportedOperationException: void <init>(java.lang.String,java.lang.Throwable)>($r22, r17) 

(declare-const var2494!1 var509)
(declare-const var2543!1 String)
(declare-const var380!1 var2486)
 ; Statement: throw $r24 
(check-sat)
; {arr-ClassObject-init=([], java.lang.Class[]), cast-from-var3907-to-var2486=([java.lang.reflect.InvocationTargetException], java.lang.Exception), arr-var313-init=([], java.lang.Object[]), getName/-1958580599=([java.lang.Class], java.lang.String), cast-from-String-to-var313=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var509-init=([], java.lang.UnsupportedOperationException), <init>/-1566289705=([java.lang.UnsupportedOperationException, java.lang.String, java.lang.Throwable], void), cast-from-var2486-to-var914=([java.lang.Exception], java.lang.Throwable)}
; {var973=org.antlr.v4.automata.ParserATNFactory, var2841=r5, var2677=r0, var1436=org.antlr.v4.tool.ast.GrammarAST, var2988=r15, var2363=$r1, var3907=java.lang.reflect.InvocationTargetException, var3644=$r11, var2486=java.lang.Exception, var380=r17, var313=java.lang.Object, var3974=$r18, var2971=org.antlr.v4.runtime.atn.ATNState, var1699=$r19, var3154=$r20, var3390=$r21, var2543=$r22, var509=java.lang.UnsupportedOperationException, var2494=$r24, var914=java.lang.Throwable}
; {org.antlr.v4.automata.ParserATNFactory=var973, r5=var2841, r0=var2677, org.antlr.v4.tool.ast.GrammarAST=var1436, r15=var2988, $r1=var2363, java.lang.reflect.InvocationTargetException=var3907, $r11=var3644, java.lang.Exception=var2486, r17=var380, java.lang.Object=var313, $r18=var3974, org.antlr.v4.runtime.atn.ATNState=var2971, $r19=var1699, $r20=var3154, $r21=var3390, $r22=var2543, java.lang.UnsupportedOperationException=var509, $r24=var2494, java.lang.Throwable=var914}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r5 := @this: org.antlr.v4.automata.ParserATNFactory;	r0 := @parameter0: java.lang.Class;	r15 := @parameter1: org.antlr.v4.tool.ast.GrammarAST;	$r1 = newarray (java.lang.Class)[0];	$r11 := @caughtexception;	r17 = $r11;	goto [?= $r18 = newarray (java.lang.Object)[2]];	$r18 = newarray (java.lang.Object)[2];	$r19 = class "Lorg/antlr/v4/runtime/atn/ATNState;";	$r20 = virtualinvoke $r19.<java.lang.Class: java.lang.String getName()>();	$r18[0] = $r20;	$r21 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$r18[1] = $r21;	$r22 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Could not create %s of type %s.", $r18);	$r24 = new java.lang.UnsupportedOperationException;	specialinvoke $r24.<java.lang.UnsupportedOperationException: void <init>(java.lang.String,java.lang.Throwable)>($r22, r17);	throw $r24
;block_num 3