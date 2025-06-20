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

(declare-sort var3454 0)
(declare-sort var112 0)
(declare-sort var2183 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun haveOutputDir/-858771875 (var3454) Bool)
(declare-fun var2183-init () var2183)
(declare-fun outputDirectory/-858771875 (var3454) String)
(declare-fun <init>/-1681595970 (var2183 String) void)
(declare-const null-var3454 var3454)
(declare-const null-String String)
(declare-const var2183-separatorChar Int)
(declare-const var838 var3454) ; Statement: r1 := @this: org.antlr.v4.Tool 
(assert (not (= var838 null-var3454)))
(declare-const var1564 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1564 null-String)))
(define-const var1103 Int var2183-separatorChar) ; Statement: $c0 = <java.io.File: char separatorChar> 
(define-const var544 Int (cast-from-Int-to-Int var1103)) ; Statement: $i4 = (int) $c0 
(assert true)
(define-const var2810 Int (lastIndexOf/-1292097097 var1564 var544)) ; Statement: $i1 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>($i4) 
(define-const var1631 Int (cast-from-Int-to-Int -1)) ; Statement: $i6 = (int) -1 
 ; Statement: if $i1 != $i6 goto $c2 = <java.io.File: char separatorChar> 
(assert (not (not (= var2810 var1631)))) ; Negate: Cond: $i1 != $i6  
(define-const var1432 String ".") ; Statement: r5 = "." 
 ; Statement: goto [?= $z0 = r1.<org.antlr.v4.Tool: boolean haveOutputDir>] 
(assert true) ; Non Conditional
(define-const var188 Bool (haveOutputDir/-858771875 var838)) ; Statement: $z0 = r1.<org.antlr.v4.Tool: boolean haveOutputDir> 
 ; Statement: if $z0 == 0 goto $r8 = new java.io.File 
(assert (not (= (ite var188 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2366 var2183 var2183-init) ; Statement: $r7 = new java.io.File 
(define-const var1894 String (outputDirectory/-858771875 var838)) ; Statement: $r4 = r1.<org.antlr.v4.Tool: java.lang.String outputDirectory> 
(assert true)
;(assert (<init>/-1681595970 var2366 var1894)) ; Statement: specialinvoke $r7.<java.io.File: void <init>(java.lang.String)>($r4) 

(declare-const var2366!1 var2183)
(declare-const var1894!1 String)
(define-const var2172 var2183 var2366!1) ; Statement: r6 = $r7 
 ; Statement: goto [?= return r6] 
(assert true) ; Non Conditional
 ; Statement: return r6 
(check-sat)
; {cast-from-Int-to-Int=([char], int), lastIndexOf/-1292097097=([java.lang.String, int], int), haveOutputDir/-858771875=([org.antlr.v4.Tool], boolean), var2183-init=([], java.io.File), outputDirectory/-858771875=([org.antlr.v4.Tool], java.lang.String), <init>/-1681595970=([java.io.File, java.lang.String], void)}
; {var3454=org.antlr.v4.Tool, var838=r1, var1564=r0, var112=null_type, var2183=java.io.File, var1103=$c0, var544=$i4, var2810=$i1, var1631=$i6, var1432=r5, var188=$z0, var2366=$r7, var1894=$r4, var2172=r6}
; {org.antlr.v4.Tool=var3454, r1=var838, r0=var1564, null_type=var112, java.io.File=var2183, $c0=var1103, $i4=var544, $i1=var2810, $i6=var1631, r5=var1432, $z0=var188, $r7=var2366, $r4=var1894, r6=var2172}
;seq <java.lang.String: int lastIndexOf(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1}
;stmts r1 := @this: org.antlr.v4.Tool;	r0 := @parameter0: java.lang.String;	$c0 = <java.io.File: char separatorChar>;	$i4 = (int) $c0;	$i1 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>($i4);	$i6 = (int) -1;	if $i1 != $i6 goto $c2 = <java.io.File: char separatorChar>;	r5 = ".";	goto [?= $z0 = r1.<org.antlr.v4.Tool: boolean haveOutputDir>];	$z0 = r1.<org.antlr.v4.Tool: boolean haveOutputDir>;	if $z0 == 0 goto $r8 = new java.io.File;	$r7 = new java.io.File;	$r4 = r1.<org.antlr.v4.Tool: java.lang.String outputDirectory>;	specialinvoke $r7.<java.io.File: void <init>(java.lang.String)>($r4);	r6 = $r7;	goto [?= return r6];	return r6
;block_num 5