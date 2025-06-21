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

(declare-sort var2282 0)
(declare-sort var2096 0)
(declare-sort var1585 0)
(declare-sort var2855 0)
(declare-sort var1254 0)
(declare-sort var2695 0)
(declare-sort var3210 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var2855-to-var1254 (var2855) var1254)
(declare-fun setInputStream/1316143536 (var2096 var1254) void)
(declare-fun var2695-init () var2695)
(declare-fun cast-from-var2096-to-var3210 (var2096) var3210)
(declare-fun <init>/841258605 (var2695 var3210) void)
(declare-fun fill/-154847421 (var2695) void)
(declare-fun showTokens/-1895086842 (var2282) Bool)
(declare-fun startRuleName/-1895086842 (var2282) String)
(declare-const null-var2282 var2282)
(declare-const null-var2096 var2096)
(declare-const null-ClassObject ClassObject)
(declare-const null-var1585 var1585)
(declare-const null-var2855 var2855)
(declare-const var2698 var2282) ; Statement: r3 := @this: org.antlr.v4.gui.TestRig 
(assert (not (= var2698 null-var2282)))
(declare-const var2085 var2096) ; Statement: r0 := @parameter0: org.antlr.v4.runtime.Lexer 
(assert (not (= var2085 null-var2096)))
(declare-const var3083 ClassObject) ; Statement: r6 := @parameter1: java.lang.Class 
(assert (not (= var3083 null-ClassObject)))
(declare-const var3056 var1585) ; Statement: r5 := @parameter2: org.antlr.v4.runtime.Parser 
(assert (not (= var3056 null-var1585)))
(declare-const var2479 var2855) ; Statement: r1 := @parameter3: org.antlr.v4.runtime.CharStream 
(assert (not (= var2479 null-var2855)))
(define-const var2438 var1254 (cast-from-var2855-to-var1254 var2479)) ; Statement: $r40 = (org.antlr.v4.runtime.IntStream) r1 
(assert true)
;(assert (setInputStream/1316143536 var2085 var2438)) ; Statement: virtualinvoke r0.<org.antlr.v4.runtime.Lexer: void setInputStream(org.antlr.v4.runtime.IntStream)>($r40) 

(declare-const var2085!1 var2096)
(declare-const var2438!1 var1254)
(define-const var944 var2695 var2695-init) ; Statement: $r38 = new org.antlr.v4.runtime.CommonTokenStream 
(define-const var3794 var3210 (cast-from-var2096-to-var3210 var2085!1)) ; Statement: $r41 = (org.antlr.v4.runtime.TokenSource) r0 
(assert true)
;(assert (<init>/841258605 var944 var3794)) ; Statement: specialinvoke $r38.<org.antlr.v4.runtime.CommonTokenStream: void <init>(org.antlr.v4.runtime.TokenSource)>($r41) 

(declare-const var944!1 var2695)
(declare-const var3794!1 var3210)
(assert true)
;(assert (fill/-154847421 var944!1)) ; Statement: virtualinvoke $r38.<org.antlr.v4.runtime.CommonTokenStream: void fill()>() 

(declare-const var944!2 var2695)
(define-const var1494 Bool (showTokens/-1895086842 var2698)) ; Statement: $z0 = r3.<org.antlr.v4.gui.TestRig: boolean showTokens> 
 ; Statement: if $z0 == 0 goto $r4 = r3.<org.antlr.v4.gui.TestRig: java.lang.String startRuleName> 
(assert (= (ite var1494 1 0) 0)) ; Cond: $z0 == 0 
(define-const var864 String (startRuleName/-1895086842 var2698)) ; Statement: $r4 = r3.<org.antlr.v4.gui.TestRig: java.lang.String startRuleName> 
(assert true)
(define-const var2967 Bool (= var864 "tokens")) ; Statement: $z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>("tokens") 
 ; Statement: if $z1 == 0 goto $z2 = r3.<org.antlr.v4.gui.TestRig: boolean diagnostics> 
(assert (not (= (ite var2967 1 0) 0))) ; Negate: Cond: $z1 == 0  
 ; Statement: return 
(check-sat)
; {cast-from-var2855-to-var1254=([org.antlr.v4.runtime.CharStream], org.antlr.v4.runtime.IntStream), setInputStream/1316143536=([org.antlr.v4.runtime.Lexer, org.antlr.v4.runtime.IntStream], void), var2695-init=([], org.antlr.v4.runtime.CommonTokenStream), cast-from-var2096-to-var3210=([org.antlr.v4.runtime.Lexer], org.antlr.v4.runtime.TokenSource), <init>/841258605=([org.antlr.v4.runtime.CommonTokenStream, org.antlr.v4.runtime.TokenSource], void), fill/-154847421=([org.antlr.v4.runtime.CommonTokenStream], void), showTokens/-1895086842=([org.antlr.v4.gui.TestRig], boolean), startRuleName/-1895086842=([org.antlr.v4.gui.TestRig], java.lang.String)}
; {var2282=org.antlr.v4.gui.TestRig, var2698=r3, var2096=org.antlr.v4.runtime.Lexer, var2085=r0, var3083=r6, var1585=org.antlr.v4.runtime.Parser, var3056=r5, var2855=org.antlr.v4.runtime.CharStream, var2479=r1, var1254=org.antlr.v4.runtime.IntStream, var2438=$r40, var2695=org.antlr.v4.runtime.CommonTokenStream, var944=$r38, var3210=org.antlr.v4.runtime.TokenSource, var3794=$r41, var1494=$z0, var864=$r4, var2967=$z1}
; {org.antlr.v4.gui.TestRig=var2282, r3=var2698, org.antlr.v4.runtime.Lexer=var2096, r0=var2085, r6=var3083, org.antlr.v4.runtime.Parser=var1585, r5=var3056, org.antlr.v4.runtime.CharStream=var2855, r1=var2479, org.antlr.v4.runtime.IntStream=var1254, $r40=var2438, org.antlr.v4.runtime.CommonTokenStream=var2695, $r38=var944, org.antlr.v4.runtime.TokenSource=var3210, $r41=var3794, $z0=var1494, $r4=var864, $z1=var2967}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.antlr.v4.gui.TestRig;	r0 := @parameter0: org.antlr.v4.runtime.Lexer;	r6 := @parameter1: java.lang.Class;	r5 := @parameter2: org.antlr.v4.runtime.Parser;	r1 := @parameter3: org.antlr.v4.runtime.CharStream;	$r40 = (org.antlr.v4.runtime.IntStream) r1;	virtualinvoke r0.<org.antlr.v4.runtime.Lexer: void setInputStream(org.antlr.v4.runtime.IntStream)>($r40);	$r38 = new org.antlr.v4.runtime.CommonTokenStream;	$r41 = (org.antlr.v4.runtime.TokenSource) r0;	specialinvoke $r38.<org.antlr.v4.runtime.CommonTokenStream: void <init>(org.antlr.v4.runtime.TokenSource)>($r41);	virtualinvoke $r38.<org.antlr.v4.runtime.CommonTokenStream: void fill()>();	$z0 = r3.<org.antlr.v4.gui.TestRig: boolean showTokens>;	if $z0 == 0 goto $r4 = r3.<org.antlr.v4.gui.TestRig: java.lang.String startRuleName>;	$r4 = r3.<org.antlr.v4.gui.TestRig: java.lang.String startRuleName>;	$z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>("tokens");	if $z1 == 0 goto $z2 = r3.<org.antlr.v4.gui.TestRig: boolean diagnostics>;	return
;block_num 3