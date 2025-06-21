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

(declare-sort var819 0)
(declare-sort var868 0)
(declare-sort var107 0)
(declare-sort var3958 0)
(declare-sort var817 0)
(declare-sort var3651 0)
(declare-sort var3864 0)
(declare-sort var3189 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3651!class ClassObject)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun cast-from-var107-to-var3958 (var107) var3958)
(declare-fun arr-var817-init () (Array Int var817))
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun cast-from-String-to-var817 (String) var817)
(declare-fun String_format/1339386452 (String (Array Int var817)) String)
(declare-fun var3864-init () var3864)
(declare-fun <init>/-1566289705 (var3864 String var3189) void)
(declare-fun cast-from-var3958-to-var3189 (var3958) var3189)
(declare-const null-var819 var819)
(declare-const null-ClassObject ClassObject)
(declare-const null-var868 var868)
(declare-const null-var107 var107)
(declare-const null-__Array__Int__var817__ (Array Int var817))
(declare-const var2464 var819) ; Statement: r5 := @this: org.antlr.v4.automata.ParserATNFactory 
(assert (not (= var2464 null-var819)))
(declare-const var2335 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var2335 null-ClassObject)))
(declare-const var435 var868) ; Statement: r15 := @parameter1: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var435 null-var868)))
(define-const var3917 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r1 = newarray (java.lang.Class)[0] 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var83 var107) ; Statement: $r12 := @caughtexception 
(assert (not (= var83 null-var107)))
(define-const var926 var3958 (cast-from-var107-to-var3958 var83)) ; Statement: r17 = $r12 
 ; Statement: goto [?= $r18 = newarray (java.lang.Object)[2]] 
(assert true) ; Non Conditional
(define-const var2935 (Array Int var817) arr-var817-init) ; Statement: $r18 = newarray (java.lang.Object)[2] 
(define-const var1643 ClassObject var3651!class) ; Statement: $r19 = class "Lorg/antlr/v4/runtime/atn/ATNState;" 
(assert true)
(define-const var197 String (getName/-1958580599 var1643)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.Class: java.lang.String getName()>() 
(declare-const var2935!1 (Array Int var817))
(assert (not (= var2935!1 null-__Array__Int__var817__)))
(assert (= (select var2935!1 0) (cast-from-String-to-var817 var197))) ; Statement: $r18[0] = $r20 
(assert true)
(define-const var2009 String (getName/-1958580599 var2335)) ; Statement: $r21 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(declare-const var2935!2 (Array Int var817))
(assert (not (= var2935!2 null-__Array__Int__var817__)))
(assert (= (select var2935!2 1) (cast-from-String-to-var817 var2009))) ; Statement: $r18[1] = $r21 
(define-const var2386 String (String_format/1339386452 "Could not create %s of type %s." var2935!2)) ; Statement: $r22 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Could not create %s of type %s.", $r18) 
(define-const var1851 var3864 var3864-init) ; Statement: $r24 = new java.lang.UnsupportedOperationException 
(assert true)
;(assert (<init>/-1566289705 var1851 var2386 (cast-from-var3958-to-var3189 var926))) ; Statement: specialinvoke $r24.<java.lang.UnsupportedOperationException: void <init>(java.lang.String,java.lang.Throwable)>($r22, r17) 

(declare-const var1851!1 var3864)
(declare-const var2386!1 String)
(declare-const var926!1 var3958)
 ; Statement: throw $r24 
(check-sat)
; {arr-ClassObject-init=([], java.lang.Class[]), cast-from-var107-to-var3958=([java.lang.IllegalArgumentException], java.lang.Exception), arr-var817-init=([], java.lang.Object[]), getName/-1958580599=([java.lang.Class], java.lang.String), cast-from-String-to-var817=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var3864-init=([], java.lang.UnsupportedOperationException), <init>/-1566289705=([java.lang.UnsupportedOperationException, java.lang.String, java.lang.Throwable], void), cast-from-var3958-to-var3189=([java.lang.Exception], java.lang.Throwable)}
; {var819=org.antlr.v4.automata.ParserATNFactory, var2464=r5, var2335=r0, var868=org.antlr.v4.tool.ast.GrammarAST, var435=r15, var3917=$r1, var107=java.lang.IllegalArgumentException, var83=$r12, var3958=java.lang.Exception, var926=r17, var817=java.lang.Object, var2935=$r18, var3651=org.antlr.v4.runtime.atn.ATNState, var1643=$r19, var197=$r20, var2009=$r21, var2386=$r22, var3864=java.lang.UnsupportedOperationException, var1851=$r24, var3189=java.lang.Throwable}
; {org.antlr.v4.automata.ParserATNFactory=var819, r5=var2464, r0=var2335, org.antlr.v4.tool.ast.GrammarAST=var868, r15=var435, $r1=var3917, java.lang.IllegalArgumentException=var107, $r12=var83, java.lang.Exception=var3958, r17=var926, java.lang.Object=var817, $r18=var2935, org.antlr.v4.runtime.atn.ATNState=var3651, $r19=var1643, $r20=var197, $r21=var2009, $r22=var2386, java.lang.UnsupportedOperationException=var3864, $r24=var1851, java.lang.Throwable=var3189}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r5 := @this: org.antlr.v4.automata.ParserATNFactory;	r0 := @parameter0: java.lang.Class;	r15 := @parameter1: org.antlr.v4.tool.ast.GrammarAST;	$r1 = newarray (java.lang.Class)[0];	$r12 := @caughtexception;	r17 = $r12;	goto [?= $r18 = newarray (java.lang.Object)[2]];	$r18 = newarray (java.lang.Object)[2];	$r19 = class "Lorg/antlr/v4/runtime/atn/ATNState;";	$r20 = virtualinvoke $r19.<java.lang.Class: java.lang.String getName()>();	$r18[0] = $r20;	$r21 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$r18[1] = $r21;	$r22 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Could not create %s of type %s.", $r18);	$r24 = new java.lang.UnsupportedOperationException;	specialinvoke $r24.<java.lang.UnsupportedOperationException: void <init>(java.lang.String,java.lang.Throwable)>($r22, r17);	throw $r24
;block_num 3