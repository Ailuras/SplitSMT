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

(declare-sort var2229 0)
(declare-sort var3288 0)
(declare-sort var1498 0)
(declare-sort var1344 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun input/448264395 (var1498) var3288)
(declare-fun cast-from-var2229-to-var1498 (var2229) var1498)
(declare-fun var3288_LA/-940427205 (var3288 Int) Int)
(declare-fun match/-963571158 (var1498 Int) void)
(declare-fun state/448264395 (var1498) var1344)
(declare-fun failed/1780090535 (var1344) Bool)
(declare-const null-var2229 var2229)
(declare-const var1346 var2229) ; Statement: r1 := @this: org.antlr.v4.parse.ActionSplitter 
(assert (not (= var1346 null-var2229)))
(define-const var3069 String String-init) ; Statement: $r51 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3069)) ; Statement: specialinvoke $r51.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3069!1 String)
(assert (= var3069!1 ""))
(define-const var3122 Int 0) ; Statement: i24 = 0 
(assert true) ; Non Conditional
(define-const var1097 Int 5) ; Statement: b25 = 5 
(define-const var291 var3288 (input/448264395 (cast-from-var2229-to-var1498 var1346))) ; Statement: $r2 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.CharStream input> 
(define-const var279 Int (var3288_LA/-940427205 var291 1)) ; Statement: $i2 = interfaceinvoke $r2.<org.antlr.runtime.CharStream: int LA(int)>(1) 
 ; Statement: if $i2 < 0 goto (branch) 
(assert (not (< var279 0))) ; Negate: Cond: $i2 < 0  
 ; Statement: if $i2 <= 35 goto b25 = 1 
(assert (<= var279 35)) ; Cond: $i2 <= 35 
(define-const var1097!1 Int 1) ; Statement: b25 = 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: tableswitch(b25) {     case 1: goto $r26 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.CharStream input>;     case 2: goto virtualinvoke r1.<org.antlr.v4.parse.ActionSplitter: void match(java.lang.String)>("\\$");     case 3: goto virtualinvoke r1.<org.antlr.v4.parse.ActionSplitter: void match(int)>(92);     case 4: goto $r3 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.CharStream input>;     default: goto if i24 < 1 goto $r38 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.RecognizerSharedState state>; } 
(assert (and (= var1097!1 3) (and (not (= var1097!1 2)) (and (not (= var1097!1 1)) true)))) ; Intersect: Cond: b25 == 3  and Intersect: Negate: Cond: b25 == 2   and Intersect: Negate: Cond: b25 == 1   and Non Conditional   
(assert true)
;(assert (match/-963571158 (cast-from-var2229-to-var1498 var1346) 92)) ; Statement: virtualinvoke r1.<org.antlr.v4.parse.ActionSplitter: void match(int)>(92) 

(declare-const var1346!1 var2229)
(declare-const var2752 Int)
(define-const var2311 var1344 (state/448264395 (cast-from-var2229-to-var1498 var1346!1))) ; Statement: $r10 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.RecognizerSharedState state> 
(define-const var2404 Bool (failed/1780090535 var2311)) ; Statement: $z2 = $r10.<org.antlr.runtime.RecognizerSharedState: boolean failed> 
 ; Statement: if $z2 == 0 goto $r11 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.CharStream input> 
(assert (not (= (ite var2404 1 0) 0))) ; Negate: Cond: $z2 == 0  
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), input/448264395=([org.antlr.runtime.Lexer], org.antlr.runtime.CharStream), cast-from-var2229-to-var1498=([org.antlr.v4.parse.ActionSplitter], org.antlr.runtime.Lexer), var3288_LA/-940427205=([org.antlr.runtime.CharStream, int], int), match/-963571158=([org.antlr.runtime.Lexer, int], void), state/448264395=([org.antlr.runtime.Lexer], org.antlr.runtime.RecognizerSharedState), failed/1780090535=([org.antlr.runtime.RecognizerSharedState], boolean)}
; {var2229=org.antlr.v4.parse.ActionSplitter, var1346=r1, var3069=$r51, var3122=i24, var1097=b25, var3288=org.antlr.runtime.CharStream, var1498=org.antlr.runtime.Lexer, var291=$r2, var279=$i2, var2752=92, var1344=org.antlr.runtime.RecognizerSharedState, var2311=$r10, var2404=$z2}
; {org.antlr.v4.parse.ActionSplitter=var2229, r1=var1346, $r51=var3069, i24=var3122, b25=var1097, org.antlr.runtime.CharStream=var3288, org.antlr.runtime.Lexer=var1498, $r2=var291, $i2=var279, 92=var2752, org.antlr.runtime.RecognizerSharedState=var1344, $r10=var2311, $z2=var2404}
;seq <java.lang.StringBuilder: void <init>()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1}
;stmts r1 := @this: org.antlr.v4.parse.ActionSplitter;	$r51 = new java.lang.StringBuilder;	specialinvoke $r51.<java.lang.StringBuilder: void <init>()>();	i24 = 0;	b25 = 5;	$r2 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.CharStream input>;	$i2 = interfaceinvoke $r2.<org.antlr.runtime.CharStream: int LA(int)>(1);	if $i2 < 0 goto (branch);	if $i2 <= 35 goto b25 = 1;	b25 = 1;	goto [?= (branch)];	tableswitch(b25) {     case 1: goto $r26 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.CharStream input>;     case 2: goto virtualinvoke r1.<org.antlr.v4.parse.ActionSplitter: void match(java.lang.String)>("\\$");     case 3: goto virtualinvoke r1.<org.antlr.v4.parse.ActionSplitter: void match(int)>(92);     case 4: goto $r3 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.CharStream input>;     default: goto if i24 < 1 goto $r38 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.RecognizerSharedState state>; };	virtualinvoke r1.<org.antlr.v4.parse.ActionSplitter: void match(int)>(92);	$r10 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.RecognizerSharedState state>;	$z2 = $r10.<org.antlr.runtime.RecognizerSharedState: boolean failed>;	if $z2 == 0 goto $r11 = r1.<org.antlr.v4.parse.ActionSplitter: org.antlr.runtime.CharStream input>;	return
;block_num 7