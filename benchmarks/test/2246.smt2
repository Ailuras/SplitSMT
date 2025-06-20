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

(declare-sort var3598 0)
(declare-sort var3706 0)
(declare-sort var467 0)
(declare-sort var2601 0)
(declare-sort var3272 0)
(declare-sort var2671 0)
(declare-sort var3282 0)
(declare-sort var1966 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2671!class ClassObject)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun cast-from-var467-to-var2601 (var467) var2601)
(declare-fun arr-var3272-init () (Array Int var3272))
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun cast-from-String-to-var3272 (String) var3272)
(declare-fun String_format/1339386452 (String (Array Int var3272)) String)
(declare-fun var3282-init () var3282)
(declare-fun <init>/-1566289705 (var3282 String var1966) void)
(declare-fun cast-from-var2601-to-var1966 (var2601) var1966)
(declare-const null-var3598 var3598)
(declare-const null-ClassObject ClassObject)
(declare-const null-var3706 var3706)
(declare-const null-var467 var467)
(declare-const null-__Array__Int__var3272__ (Array Int var3272))
(declare-const var3943 var3598) ; Statement: r5 := @this: org.antlr.v4.automata.ParserATNFactory 
(assert (not (= var3943 null-var3598)))
(declare-const var3348 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var3348 null-ClassObject)))
(declare-const var2453 var3706) ; Statement: r15 := @parameter1: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var2453 null-var3706)))
(define-const var1551 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r1 = newarray (java.lang.Class)[0] 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2045 var467) ; Statement: $r9 := @caughtexception 
(assert (not (= var2045 null-var467)))
(define-const var2680 var2601 (cast-from-var467-to-var2601 var2045)) ; Statement: r17 = $r9 
(assert true) ; Non Conditional
(define-const var2328 (Array Int var3272) arr-var3272-init) ; Statement: $r18 = newarray (java.lang.Object)[2] 
(define-const var3651 ClassObject var2671!class) ; Statement: $r19 = class "Lorg/antlr/v4/runtime/atn/ATNState;" 
(assert true)
(define-const var2265 String (getName/-1958580599 var3651)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.Class: java.lang.String getName()>() 
(declare-const var2328!1 (Array Int var3272))
(assert (not (= var2328!1 null-__Array__Int__var3272__)))
(assert (= (select var2328!1 0) (cast-from-String-to-var3272 var2265))) ; Statement: $r18[0] = $r20 
(assert true)
(define-const var1878 String (getName/-1958580599 var3348)) ; Statement: $r21 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(declare-const var2328!2 (Array Int var3272))
(assert (not (= var2328!2 null-__Array__Int__var3272__)))
(assert (= (select var2328!2 1) (cast-from-String-to-var3272 var1878))) ; Statement: $r18[1] = $r21 
(define-const var2942 String (String_format/1339386452 "Could not create %s of type %s." var2328!2)) ; Statement: $r22 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Could not create %s of type %s.", $r18) 
(define-const var1038 var3282 var3282-init) ; Statement: $r24 = new java.lang.UnsupportedOperationException 
(assert true)
;(assert (<init>/-1566289705 var1038 var2942 (cast-from-var2601-to-var1966 var2680))) ; Statement: specialinvoke $r24.<java.lang.UnsupportedOperationException: void <init>(java.lang.String,java.lang.Throwable)>($r22, r17) 

(declare-const var1038!1 var3282)
(declare-const var2942!1 String)
(declare-const var2680!1 var2601)
 ; Statement: throw $r24 
(check-sat)
; {arr-ClassObject-init=([], java.lang.Class[]), cast-from-var467-to-var2601=([java.lang.SecurityException], java.lang.Exception), arr-var3272-init=([], java.lang.Object[]), getName/-1958580599=([java.lang.Class], java.lang.String), cast-from-String-to-var3272=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var3282-init=([], java.lang.UnsupportedOperationException), <init>/-1566289705=([java.lang.UnsupportedOperationException, java.lang.String, java.lang.Throwable], void), cast-from-var2601-to-var1966=([java.lang.Exception], java.lang.Throwable)}
; {var3598=org.antlr.v4.automata.ParserATNFactory, var3943=r5, var3348=r0, var3706=org.antlr.v4.tool.ast.GrammarAST, var2453=r15, var1551=$r1, var467=java.lang.SecurityException, var2045=$r9, var2601=java.lang.Exception, var2680=r17, var3272=java.lang.Object, var2328=$r18, var2671=org.antlr.v4.runtime.atn.ATNState, var3651=$r19, var2265=$r20, var1878=$r21, var2942=$r22, var3282=java.lang.UnsupportedOperationException, var1038=$r24, var1966=java.lang.Throwable}
; {org.antlr.v4.automata.ParserATNFactory=var3598, r5=var3943, r0=var3348, org.antlr.v4.tool.ast.GrammarAST=var3706, r15=var2453, $r1=var1551, java.lang.SecurityException=var467, $r9=var2045, java.lang.Exception=var2601, r17=var2680, java.lang.Object=var3272, $r18=var2328, org.antlr.v4.runtime.atn.ATNState=var2671, $r19=var3651, $r20=var2265, $r21=var1878, $r22=var2942, java.lang.UnsupportedOperationException=var3282, $r24=var1038, java.lang.Throwable=var1966}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r5 := @this: org.antlr.v4.automata.ParserATNFactory;	r0 := @parameter0: java.lang.Class;	r15 := @parameter1: org.antlr.v4.tool.ast.GrammarAST;	$r1 = newarray (java.lang.Class)[0];	$r9 := @caughtexception;	r17 = $r9;	$r18 = newarray (java.lang.Object)[2];	$r19 = class "Lorg/antlr/v4/runtime/atn/ATNState;";	$r20 = virtualinvoke $r19.<java.lang.Class: java.lang.String getName()>();	$r18[0] = $r20;	$r21 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$r18[1] = $r21;	$r22 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Could not create %s of type %s.", $r18);	$r24 = new java.lang.UnsupportedOperationException;	specialinvoke $r24.<java.lang.UnsupportedOperationException: void <init>(java.lang.String,java.lang.Throwable)>($r22, r17);	throw $r24
;block_num 3