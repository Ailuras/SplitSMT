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

(declare-sort var3001 0)
(declare-sort var3071 0)
(declare-sort var1538 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun haveOutputDir/-858771875 (var3001) Bool)
(declare-fun var1538-init () var1538)
(declare-fun outputDirectory/-858771875 (var3001) String)
(declare-fun <init>/-1681595970 (var1538 String) void)
(declare-const null-var3001 var3001)
(declare-const null-String String)
(declare-const var1538-separatorChar Int)
(declare-const var2772 var3001) ; Statement: r1 := @this: org.antlr.v4.Tool 
(assert (not (= var2772 null-var3001)))
(declare-const var2510 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2510 null-String)))
(define-const var2129 Int var1538-separatorChar) ; Statement: $c0 = <java.io.File: char separatorChar> 
(define-const var3754 Int (cast-from-Int-to-Int var2129)) ; Statement: $i4 = (int) $c0 
(assert true)
(define-const var973 Int (lastIndexOf/-1292097097 var2510 var3754)) ; Statement: $i1 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>($i4) 
(define-const var2708 Int (cast-from-Int-to-Int -1)) ; Statement: $i6 = (int) -1 
 ; Statement: if $i1 != $i6 goto $c2 = <java.io.File: char separatorChar> 
(assert (not (= var973 var2708))) ; Cond: $i1 != $i6 
(define-const var2074 Int var1538-separatorChar) ; Statement: $c2 = <java.io.File: char separatorChar> 
(define-const var1603 Int (cast-from-Int-to-Int var2074)) ; Statement: $i7 = (int) $c2 
(assert true)
(define-const var2680 Int (lastIndexOf/-1292097097 var2510 var1603)) ; Statement: $i3 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>($i7) 
(assert (not (and true (and (>= 0 0) (>= (str.len var2510) var2680) (>= var2680 0)))))
(check-sat)
; {cast-from-Int-to-Int=([char], int), lastIndexOf/-1292097097=([java.lang.String, int], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), haveOutputDir/-858771875=([org.antlr.v4.Tool], boolean), var1538-init=([], java.io.File), outputDirectory/-858771875=([org.antlr.v4.Tool], java.lang.String), <init>/-1681595970=([java.io.File, java.lang.String], void)}
; {var3001=org.antlr.v4.Tool, var2772=r1, var2510=r0, var3071=null_type, var1538=java.io.File, var2129=$c0, var3754=$i4, var973=$i1, var2708=$i6, var2074=$c2, var1603=$i7, var2680=$i3, var1620=r5, var15=$z0, var244=$r7, var1095=$r4, var3270=r6}
; {org.antlr.v4.Tool=var3001, r1=var2772, r0=var2510, null_type=var3071, java.io.File=var1538, $c0=var2129, $i4=var3754, $i1=var973, $i6=var2708, $c2=var2074, $i7=var1603, $i3=var2680, r5=var1620, $z0=var15, $r7=var244, $r4=var1095, r6=var3270}
;seq <java.lang.String: int lastIndexOf(int)>;	<java.lang.String: int lastIndexOf(int)>;	<java.lang.String: java.lang.String substring(int,int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 2,"<java.lang.String: java.lang.String substring(int,int)>": 1}
;stmts r1 := @this: org.antlr.v4.Tool;	r0 := @parameter0: java.lang.String;	$c0 = <java.io.File: char separatorChar>;	$i4 = (int) $c0;	$i1 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>($i4);	$i6 = (int) -1;	if $i1 != $i6 goto $c2 = <java.io.File: char separatorChar>;	$c2 = <java.io.File: char separatorChar>;	$i7 = (int) $c2;	$i3 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>($i7);	r5 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, $i3);	$z0 = r1.<org.antlr.v4.Tool: boolean haveOutputDir>;	if $z0 == 0 goto $r8 = new java.io.File;	$r7 = new java.io.File;	$r4 = r1.<org.antlr.v4.Tool: java.lang.String outputDirectory>;	specialinvoke $r7.<java.io.File: void <init>(java.lang.String)>($r4);	r6 = $r7;	goto [?= return r6];	return r6
;block_num 5