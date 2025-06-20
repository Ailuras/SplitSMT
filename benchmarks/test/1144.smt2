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

(declare-sort var3833 0)
(declare-sort var3291 0)
(declare-sort var3252 0)
(declare-sort var1861 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getTokenLiteralNames/-735587768 (var3833) (Array Int String))
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun getTokenSymbolicNames/-118584061 (var3833) (Array Int String))
(declare-fun getRuleNames/229501902 (var3833) (Array Int String))
(declare-fun isLexer/-1190139949 (var3833) Bool)
(declare-fun atn/976633046 (var3833) var3291)
(declare-fun var1861_getSerialized/1369119164 (var3291) var3252)
(declare-fun toString/1795968565 (var3252) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3833 var3833)
(declare-const var420 var3833) ; Statement: r1 := @parameter0: org.antlr.v4.tool.Grammar 
(assert (not (= var420 null-var3833)))
(define-const var1428 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1428)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1428!1 String)
(assert (= var1428!1 ""))
(assert true)
;(assert (append/672562846 var1428!1 "token literal names:\n")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("token literal names:\n") 
(declare-const var1428!2 String)
(assert (= var1428!2 (str.++ var1428!1 "token literal names:\n")))
(assert true)
(define-const var208 (Array Int String) (getTokenLiteralNames/-735587768 var420)) ; Statement: r17 = virtualinvoke r1.<org.antlr.v4.tool.Grammar: java.lang.String[] getTokenLiteralNames()>() 
(define-const var2414 Int (getLength-Arr-String-1 var208)) ; Statement: i0 = lengthof r17 
(define-const var78 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(assert (>= var78 var2414)) ; Cond: i1 >= i0 
(assert true)
;(assert (append/672562846 var1428!2 "\n")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var1428!3 String)
(assert (= var1428!3 (str.++ var1428!2 "\n")))
(assert true)
;(assert (append/672562846 var1428!3 "token symbolic names:\n")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("token symbolic names:\n") 
(declare-const var1428!4 String)
(assert (= var1428!4 (str.++ var1428!3 "token symbolic names:\n")))
(assert true)
(define-const var1656 (Array Int String) (getTokenSymbolicNames/-118584061 var420)) ; Statement: r19 = virtualinvoke r1.<org.antlr.v4.tool.Grammar: java.lang.String[] getTokenSymbolicNames()>() 
(define-const var237 Int (getLength-Arr-String-1 var1656)) ; Statement: i2 = lengthof r19 
(define-const var2682 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i2 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(assert (>= var2682 var237)) ; Cond: i3 >= i2 
(assert true)
;(assert (append/672562846 var1428!4 "\n")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var1428!5 String)
(assert (= var1428!5 (str.++ var1428!4 "\n")))
(assert true)
;(assert (append/672562846 var1428!5 "rule names:\n")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("rule names:\n") 
(declare-const var1428!6 String)
(assert (= var1428!6 (str.++ var1428!5 "rule names:\n")))
(assert true)
(define-const var3823 (Array Int String) (getRuleNames/229501902 var420)) ; Statement: r21 = virtualinvoke r1.<org.antlr.v4.tool.Grammar: java.lang.String[] getRuleNames()>() 
(define-const var1296 Int (getLength-Arr-String-1 var3823)) ; Statement: i4 = lengthof r21 
(define-const var2886 Int 0) ; Statement: i5 = 0 
(assert true) ; Non Conditional
 ; Statement: if i5 >= i4 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(assert (>= var2886 var1296)) ; Cond: i5 >= i4 
(assert true)
;(assert (append/672562846 var1428!6 "\n")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var1428!7 String)
(assert (= var1428!7 (str.++ var1428!6 "\n")))
(assert true)
(define-const var3027 Bool (isLexer/-1190139949 var420)) ; Statement: $z0 = virtualinvoke r1.<org.antlr.v4.tool.Grammar: boolean isLexer()>() 
 ; Statement: if $z0 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(assert (= (ite var3027 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var1428!7 "\n")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var1428!8 String)
(assert (= var1428!8 (str.++ var1428!7 "\n")))
(define-const var2587 var3291 (atn/976633046 var420)) ; Statement: $r2 = r1.<org.antlr.v4.tool.Grammar: org.antlr.v4.runtime.atn.ATN atn> 
(define-const var667 var3252 (var1861_getSerialized/1369119164 var2587)) ; Statement: $r9 = staticinvoke <org.antlr.v4.runtime.atn.ATNSerializer: org.antlr.v4.runtime.misc.IntegerList getSerialized(org.antlr.v4.runtime.atn.ATN)>($r2) 
(assert true)
;(assert (append/672562846 var1428!8 "atn:\n")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("atn:\n") 
(declare-const var1428!9 String)
(assert (= var1428!9 (str.++ var1428!8 "atn:\n")))
(assert true)
(define-const var2358 String (toString/1795968565 var667)) ; Statement: $r3 = virtualinvoke $r9.<org.antlr.v4.runtime.misc.IntegerList: java.lang.String toString()>() 
(assert true)
;(assert (append/672562846 var1428!9 var2358)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1428!10 String)
(assert (= var1428!10 (str.++ var1428!9 var2358)))
(assert true)
(define-const var3160 String (toString/-2075883882 var1428!10)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getTokenLiteralNames/-735587768=([org.antlr.v4.tool.Grammar], java.lang.String[]), getLength-Arr-String-1=([java.lang.String[]], int), getTokenSymbolicNames/-118584061=([org.antlr.v4.tool.Grammar], java.lang.String[]), getRuleNames/229501902=([org.antlr.v4.tool.Grammar], java.lang.String[]), isLexer/-1190139949=([org.antlr.v4.tool.Grammar], boolean), atn/976633046=([org.antlr.v4.tool.Grammar], org.antlr.v4.runtime.atn.ATN), var1861_getSerialized/1369119164=([org.antlr.v4.runtime.atn.ATN], org.antlr.v4.runtime.misc.IntegerList), toString/1795968565=([org.antlr.v4.runtime.misc.IntegerList], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3833=org.antlr.v4.tool.Grammar, var420=r1, var1428=$r0, var208=r17, var2414=i0, var78=i1, var1656=r19, var237=i2, var2682=i3, var3823=r21, var1296=i4, var2886=i5, var3027=$z0, var3291=org.antlr.v4.runtime.atn.ATN, var2587=$r2, var3252=org.antlr.v4.runtime.misc.IntegerList, var1861=org.antlr.v4.runtime.atn.ATNSerializer, var667=$r9, var2358=$r3, var3160=$r4}
; {org.antlr.v4.tool.Grammar=var3833, r1=var420, $r0=var1428, r17=var208, i0=var2414, i1=var78, r19=var1656, i2=var237, i3=var2682, r21=var3823, i4=var1296, i5=var2886, $z0=var3027, org.antlr.v4.runtime.atn.ATN=var3291, $r2=var2587, org.antlr.v4.runtime.misc.IntegerList=var3252, org.antlr.v4.runtime.atn.ATNSerializer=var1861, $r9=var667, $r3=var2358, $r4=var3160}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.antlr.v4.runtime.misc.IntegerList: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 9,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: org.antlr.v4.tool.Grammar;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("token literal names:\n");	r17 = virtualinvoke r1.<org.antlr.v4.tool.Grammar: java.lang.String[] getTokenLiteralNames()>();	i0 = lengthof r17;	i1 = 0;	if i1 >= i0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("token symbolic names:\n");	r19 = virtualinvoke r1.<org.antlr.v4.tool.Grammar: java.lang.String[] getTokenSymbolicNames()>();	i2 = lengthof r19;	i3 = 0;	if i3 >= i2 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("rule names:\n");	r21 = virtualinvoke r1.<org.antlr.v4.tool.Grammar: java.lang.String[] getRuleNames()>();	i4 = lengthof r21;	i5 = 0;	if i5 >= i4 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	$z0 = virtualinvoke r1.<org.antlr.v4.tool.Grammar: boolean isLexer()>();	if $z0 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	$r2 = r1.<org.antlr.v4.tool.Grammar: org.antlr.v4.runtime.atn.ATN atn>;	$r9 = staticinvoke <org.antlr.v4.runtime.atn.ATNSerializer: org.antlr.v4.runtime.misc.IntegerList getSerialized(org.antlr.v4.runtime.atn.ATN)>($r2);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("atn:\n");	$r3 = virtualinvoke $r9.<org.antlr.v4.runtime.misc.IntegerList: java.lang.String toString()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 8