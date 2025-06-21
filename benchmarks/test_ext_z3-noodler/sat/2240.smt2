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

(declare-sort var3528 0)
(declare-sort var1095 0)
(declare-sort var1028 0)
(declare-sort var1281 0)
(declare-sort var1435 0)
(declare-sort var175 0)
(declare-sort var226 0)
(declare-sort var467 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var175!class ClassObject)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun cast-from-var1028-to-var1281 (var1028) var1281)
(declare-fun arr-var1435-init () (Array Int var1435))
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun cast-from-String-to-var1435 (String) var1435)
(declare-fun String_format/1339386452 (String (Array Int var1435)) String)
(declare-fun var226-init () var226)
(declare-fun <init>/-1566289705 (var226 String var467) void)
(declare-fun cast-from-var1281-to-var467 (var1281) var467)
(declare-const null-var3528 var3528)
(declare-const null-ClassObject ClassObject)
(declare-const null-var1095 var1095)
(declare-const null-var1028 var1028)
(declare-const null-__Array__Int__var1435__ (Array Int var1435))
(declare-const var2602 var3528) ; Statement: r5 := @this: org.antlr.v4.automata.ParserATNFactory 
(assert (not (= var2602 null-var3528)))
(declare-const var2873 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var2873 null-ClassObject)))
(declare-const var3990 var1095) ; Statement: r15 := @parameter1: org.antlr.v4.tool.ast.GrammarAST 
(assert (not (= var3990 null-var1095)))
(define-const var1868 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r1 = newarray (java.lang.Class)[0] 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2519 var1028) ; Statement: $r10 := @caughtexception 
(assert (not (= var2519 null-var1028)))
(define-const var735 var1281 (cast-from-var1028-to-var1281 var2519)) ; Statement: r17 = $r10 
 ; Statement: goto [?= $r18 = newarray (java.lang.Object)[2]] 
(assert true) ; Non Conditional
(define-const var2386 (Array Int var1435) arr-var1435-init) ; Statement: $r18 = newarray (java.lang.Object)[2] 
(define-const var2368 ClassObject var175!class) ; Statement: $r19 = class "Lorg/antlr/v4/runtime/atn/ATNState;" 
(assert true)
(define-const var614 String (getName/-1958580599 var2368)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.Class: java.lang.String getName()>() 
(declare-const var2386!1 (Array Int var1435))
(assert (not (= var2386!1 null-__Array__Int__var1435__)))
(assert (= (select var2386!1 0) (cast-from-String-to-var1435 var614))) ; Statement: $r18[0] = $r20 
(assert true)
(define-const var3675 String (getName/-1958580599 var2873)) ; Statement: $r21 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(declare-const var2386!2 (Array Int var1435))
(assert (not (= var2386!2 null-__Array__Int__var1435__)))
(assert (= (select var2386!2 1) (cast-from-String-to-var1435 var3675))) ; Statement: $r18[1] = $r21 
(define-const var3096 String (String_format/1339386452 "Could not create %s of type %s." var2386!2)) ; Statement: $r22 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Could not create %s of type %s.", $r18) 
(define-const var2974 var226 var226-init) ; Statement: $r24 = new java.lang.UnsupportedOperationException 
(assert true)
;(assert (<init>/-1566289705 var2974 var3096 (cast-from-var1281-to-var467 var735))) ; Statement: specialinvoke $r24.<java.lang.UnsupportedOperationException: void <init>(java.lang.String,java.lang.Throwable)>($r22, r17) 

(declare-const var2974!1 var226)
(declare-const var3096!1 String)
(declare-const var735!1 var1281)
 ; Statement: throw $r24 
(check-sat)
; {arr-ClassObject-init=([], java.lang.Class[]), cast-from-var1028-to-var1281=([java.lang.NoSuchMethodException], java.lang.Exception), arr-var1435-init=([], java.lang.Object[]), getName/-1958580599=([java.lang.Class], java.lang.String), cast-from-String-to-var1435=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var226-init=([], java.lang.UnsupportedOperationException), <init>/-1566289705=([java.lang.UnsupportedOperationException, java.lang.String, java.lang.Throwable], void), cast-from-var1281-to-var467=([java.lang.Exception], java.lang.Throwable)}
; {var3528=org.antlr.v4.automata.ParserATNFactory, var2602=r5, var2873=r0, var1095=org.antlr.v4.tool.ast.GrammarAST, var3990=r15, var1868=$r1, var1028=java.lang.NoSuchMethodException, var2519=$r10, var1281=java.lang.Exception, var735=r17, var1435=java.lang.Object, var2386=$r18, var175=org.antlr.v4.runtime.atn.ATNState, var2368=$r19, var614=$r20, var3675=$r21, var3096=$r22, var226=java.lang.UnsupportedOperationException, var2974=$r24, var467=java.lang.Throwable}
; {org.antlr.v4.automata.ParserATNFactory=var3528, r5=var2602, r0=var2873, org.antlr.v4.tool.ast.GrammarAST=var1095, r15=var3990, $r1=var1868, java.lang.NoSuchMethodException=var1028, $r10=var2519, java.lang.Exception=var1281, r17=var735, java.lang.Object=var1435, $r18=var2386, org.antlr.v4.runtime.atn.ATNState=var175, $r19=var2368, $r20=var614, $r21=var3675, $r22=var3096, java.lang.UnsupportedOperationException=var226, $r24=var2974, java.lang.Throwable=var467}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r5 := @this: org.antlr.v4.automata.ParserATNFactory;	r0 := @parameter0: java.lang.Class;	r15 := @parameter1: org.antlr.v4.tool.ast.GrammarAST;	$r1 = newarray (java.lang.Class)[0];	$r10 := @caughtexception;	r17 = $r10;	goto [?= $r18 = newarray (java.lang.Object)[2]];	$r18 = newarray (java.lang.Object)[2];	$r19 = class "Lorg/antlr/v4/runtime/atn/ATNState;";	$r20 = virtualinvoke $r19.<java.lang.Class: java.lang.String getName()>();	$r18[0] = $r20;	$r21 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$r18[1] = $r21;	$r22 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Could not create %s of type %s.", $r18);	$r24 = new java.lang.UnsupportedOperationException;	specialinvoke $r24.<java.lang.UnsupportedOperationException: void <init>(java.lang.String,java.lang.Throwable)>($r22, r17);	throw $r24
;block_num 3