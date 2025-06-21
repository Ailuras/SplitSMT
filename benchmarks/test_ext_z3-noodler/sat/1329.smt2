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

(declare-sort var3413 0)
(declare-sort var683 0)
(declare-sort var3169 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun haveOutputDir/-858771875 (var3413) Bool)
(declare-fun var3169-init () var3169)
(declare-fun <init>/-1681595970 (var3169 String) void)
(declare-const null-var3413 var3413)
(declare-const null-String String)
(declare-const var3169-separatorChar Int)
(declare-const var2053 var3413) ; Statement: r1 := @this: org.antlr.v4.Tool 
(assert (not (= var2053 null-var3413)))
(declare-const var946 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var946 null-String)))
(define-const var843 Int var3169-separatorChar) ; Statement: $c0 = <java.io.File: char separatorChar> 
(define-const var63 Int (cast-from-Int-to-Int var843)) ; Statement: $i4 = (int) $c0 
(assert true)
(define-const var3529 Int (lastIndexOf/-1292097097 var946 var63)) ; Statement: $i1 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>($i4) 
(define-const var681 Int (cast-from-Int-to-Int -1)) ; Statement: $i6 = (int) -1 
 ; Statement: if $i1 != $i6 goto $c2 = <java.io.File: char separatorChar> 
(assert (not (not (= var3529 var681)))) ; Negate: Cond: $i1 != $i6  
(define-const var919 String ".") ; Statement: r5 = "." 
 ; Statement: goto [?= $z0 = r1.<org.antlr.v4.Tool: boolean haveOutputDir>] 
(assert true) ; Non Conditional
(define-const var3101 Bool (haveOutputDir/-858771875 var2053)) ; Statement: $z0 = r1.<org.antlr.v4.Tool: boolean haveOutputDir> 
 ; Statement: if $z0 == 0 goto $r8 = new java.io.File 
(assert (= (ite var3101 1 0) 0)) ; Cond: $z0 == 0 
(define-const var668 var3169 var3169-init) ; Statement: $r8 = new java.io.File 
(assert true)
;(assert (<init>/-1681595970 var668 var919)) ; Statement: specialinvoke $r8.<java.io.File: void <init>(java.lang.String)>(r5) 

(declare-const var668!1 var3169)
(declare-const var919!1 String)
(define-const var674 var3169 var668!1) ; Statement: r6 = $r8 
(assert true) ; Non Conditional
 ; Statement: return r6 
(check-sat)
; {cast-from-Int-to-Int=([char], int), lastIndexOf/-1292097097=([java.lang.String, int], int), haveOutputDir/-858771875=([org.antlr.v4.Tool], boolean), var3169-init=([], java.io.File), <init>/-1681595970=([java.io.File, java.lang.String], void)}
; {var3413=org.antlr.v4.Tool, var2053=r1, var946=r0, var683=null_type, var3169=java.io.File, var843=$c0, var63=$i4, var3529=$i1, var681=$i6, var919=r5, var3101=$z0, var668=$r8, var674=r6}
; {org.antlr.v4.Tool=var3413, r1=var2053, r0=var946, null_type=var683, java.io.File=var3169, $c0=var843, $i4=var63, $i1=var3529, $i6=var681, r5=var919, $z0=var3101, $r8=var668, r6=var674}
;seq <java.lang.String: int lastIndexOf(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1}
;stmts r1 := @this: org.antlr.v4.Tool;	r0 := @parameter0: java.lang.String;	$c0 = <java.io.File: char separatorChar>;	$i4 = (int) $c0;	$i1 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>($i4);	$i6 = (int) -1;	if $i1 != $i6 goto $c2 = <java.io.File: char separatorChar>;	r5 = ".";	goto [?= $z0 = r1.<org.antlr.v4.Tool: boolean haveOutputDir>];	$z0 = r1.<org.antlr.v4.Tool: boolean haveOutputDir>;	if $z0 == 0 goto $r8 = new java.io.File;	$r8 = new java.io.File;	specialinvoke $r8.<java.io.File: void <init>(java.lang.String)>(r5);	r6 = $r8;	return r6
;block_num 5