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

(declare-sort var2642 0)
(declare-sort var2490 0)
(declare-sort var1373 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun haveOutputDir/-858771875 (var2642) Bool)
(declare-fun var1373-init () var1373)
(declare-fun <init>/-1681595970 (var1373 String) void)
(declare-const null-var2642 var2642)
(declare-const null-String String)
(declare-const var1373-separatorChar Int)
(declare-const var2415 var2642) ; Statement: r1 := @this: org.antlr.v4.Tool 
(assert (not (= var2415 null-var2642)))
(declare-const var1086 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1086 null-String)))
(define-const var2431 Int var1373-separatorChar) ; Statement: $c0 = <java.io.File: char separatorChar> 
(define-const var171 Int (cast-from-Int-to-Int var2431)) ; Statement: $i4 = (int) $c0 
(assert true)
(define-const var3547 Int (lastIndexOf/-1292097097 var1086 var171)) ; Statement: $i1 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>($i4) 
(define-const var93 Int (cast-from-Int-to-Int -1)) ; Statement: $i6 = (int) -1 
 ; Statement: if $i1 != $i6 goto $c2 = <java.io.File: char separatorChar> 
(assert (not (= var3547 var93))) ; Cond: $i1 != $i6 
(define-const var1208 Int var1373-separatorChar) ; Statement: $c2 = <java.io.File: char separatorChar> 
(define-const var377 Int (cast-from-Int-to-Int var1208)) ; Statement: $i7 = (int) $c2 
(assert true)
(define-const var3988 Int (lastIndexOf/-1292097097 var1086 var377)) ; Statement: $i3 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>($i7) 
(assert (not (and true (and (>= 0 0) (>= (str.len var1086) var3988) (>= var3988 0)))))
(check-sat)
; {cast-from-Int-to-Int=([char], int), lastIndexOf/-1292097097=([java.lang.String, int], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), haveOutputDir/-858771875=([org.antlr.v4.Tool], boolean), var1373-init=([], java.io.File), <init>/-1681595970=([java.io.File, java.lang.String], void)}
; {var2642=org.antlr.v4.Tool, var2415=r1, var1086=r0, var2490=null_type, var1373=java.io.File, var2431=$c0, var171=$i4, var3547=$i1, var93=$i6, var1208=$c2, var377=$i7, var3988=$i3, var1649=r5, var2638=$z0, var1203=$r8, var1974=r6}
; {org.antlr.v4.Tool=var2642, r1=var2415, r0=var1086, null_type=var2490, java.io.File=var1373, $c0=var2431, $i4=var171, $i1=var3547, $i6=var93, $c2=var1208, $i7=var377, $i3=var3988, r5=var1649, $z0=var2638, $r8=var1203, r6=var1974}
;seq <java.lang.String: int lastIndexOf(int)>;	<java.lang.String: int lastIndexOf(int)>;	<java.lang.String: java.lang.String substring(int,int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 2,"<java.lang.String: java.lang.String substring(int,int)>": 1}
;stmts r1 := @this: org.antlr.v4.Tool;	r0 := @parameter0: java.lang.String;	$c0 = <java.io.File: char separatorChar>;	$i4 = (int) $c0;	$i1 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>($i4);	$i6 = (int) -1;	if $i1 != $i6 goto $c2 = <java.io.File: char separatorChar>;	$c2 = <java.io.File: char separatorChar>;	$i7 = (int) $c2;	$i3 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>($i7);	r5 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, $i3);	$z0 = r1.<org.antlr.v4.Tool: boolean haveOutputDir>;	if $z0 == 0 goto $r8 = new java.io.File;	$r8 = new java.io.File;	specialinvoke $r8.<java.io.File: void <init>(java.lang.String)>(r5);	r6 = $r8;	return r6
;block_num 5