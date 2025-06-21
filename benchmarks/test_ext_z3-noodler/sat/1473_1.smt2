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

(declare-sort var2804 0)
(declare-sort var371 0)
(declare-sort var727 0)
(declare-sort var3302 0)
(declare-sort var1579 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun tool/79370539 (var2804) var727)
(declare-fun g/79370539 (var2804) var3302)
(declare-fun fileName/976633046 (var3302) String)
(declare-fun getOutputDirectory/-1679743797 (var727 String) var1579)
(declare-fun toString/180451120 (var1579) String)
(declare-fun var1579-init () var1579)
(declare-fun <init>/-1681595970 (var1579 String) void)
(declare-const null-var2804 var2804)
(declare-const null-String String)
(declare-const var3665 var2804) ; Statement: r0 := @this: org.antlr.v4.tool.BuildDependencyGenerator 
(assert (not (= var3665 null-var2804)))
(declare-const var3896 String) ; Statement: r9 := @parameter0: java.lang.String 
(assert (not (= var3896 null-String)))
(define-const var3396 var727 (tool/79370539 var3665)) ; Statement: $r3 = r0.<org.antlr.v4.tool.BuildDependencyGenerator: org.antlr.v4.Tool tool> 
(define-const var3411 var3302 (g/79370539 var3665)) ; Statement: $r1 = r0.<org.antlr.v4.tool.BuildDependencyGenerator: org.antlr.v4.tool.Grammar g> 
(define-const var375 String (fileName/976633046 var3411)) ; Statement: $r2 = $r1.<org.antlr.v4.tool.Grammar: java.lang.String fileName> 
(assert true)
(define-const var3548 var1579 (getOutputDirectory/-1679743797 var3396 var375)) ; Statement: r17 = virtualinvoke $r3.<org.antlr.v4.Tool: java.io.File getOutputDirectory(java.lang.String)>($r2) 
(assert true)
(define-const var2948 String (toString/180451120 var3548)) ; Statement: $r4 = virtualinvoke r17.<java.io.File: java.lang.String toString()>() 
(assert true)
(define-const var3562 Bool (= var2948 ".")) ; Statement: $z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(".") 
 ; Statement: if $z0 == 0 goto $r5 = virtualinvoke r17.<java.io.File: java.lang.String toString()>() 
(assert (= (ite var3562 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2697 String (toString/180451120 var3548)) ; Statement: $r5 = virtualinvoke r17.<java.io.File: java.lang.String toString()>() 
(assert true)
(define-const var853 Bool (= var2697 ".")) ; Statement: $z1 = virtualinvoke $r5.<java.lang.String: boolean equals(java.lang.Object)>(".") 
 ; Statement: if $z1 == 0 goto $r6 = virtualinvoke r17.<java.io.File: java.lang.String getName()>() 
(assert (not (= (ite var853 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var3512 var1579 var1579-init) ; Statement: $r15 = new java.io.File 
(assert true)
;(assert (<init>/-1681595970 var3512 var3896)) ; Statement: specialinvoke $r15.<java.io.File: void <init>(java.lang.String)>(r9) 

(declare-const var3512!1 var1579)
(declare-const var3896!1 String)
 ; Statement: return $r15 
(check-sat)
; {tool/79370539=([org.antlr.v4.tool.BuildDependencyGenerator], org.antlr.v4.Tool), g/79370539=([org.antlr.v4.tool.BuildDependencyGenerator], org.antlr.v4.tool.Grammar), fileName/976633046=([org.antlr.v4.tool.Grammar], java.lang.String), getOutputDirectory/-1679743797=([org.antlr.v4.Tool, java.lang.String], java.io.File), toString/180451120=([java.io.File], java.lang.String), var1579-init=([], java.io.File), <init>/-1681595970=([java.io.File, java.lang.String], void)}
; {var2804=org.antlr.v4.tool.BuildDependencyGenerator, var3665=r0, var3896=r9, var371=null_type, var727=org.antlr.v4.Tool, var3396=$r3, var3302=org.antlr.v4.tool.Grammar, var3411=$r1, var375=$r2, var1579=java.io.File, var3548=r17, var2948=$r4, var3562=$z0, var2697=$r5, var853=$z1, var3512=$r15}
; {org.antlr.v4.tool.BuildDependencyGenerator=var2804, r0=var3665, r9=var3896, null_type=var371, org.antlr.v4.Tool=var727, $r3=var3396, org.antlr.v4.tool.Grammar=var3302, $r1=var3411, $r2=var375, java.io.File=var1579, r17=var3548, $r4=var2948, $z0=var3562, $r5=var2697, $z1=var853, $r15=var3512}
;seq <java.io.File: java.lang.String toString()>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.io.File: java.lang.String toString()>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r0 := @this: org.antlr.v4.tool.BuildDependencyGenerator;	r9 := @parameter0: java.lang.String;	$r3 = r0.<org.antlr.v4.tool.BuildDependencyGenerator: org.antlr.v4.Tool tool>;	$r1 = r0.<org.antlr.v4.tool.BuildDependencyGenerator: org.antlr.v4.tool.Grammar g>;	$r2 = $r1.<org.antlr.v4.tool.Grammar: java.lang.String fileName>;	r17 = virtualinvoke $r3.<org.antlr.v4.Tool: java.io.File getOutputDirectory(java.lang.String)>($r2);	$r4 = virtualinvoke r17.<java.io.File: java.lang.String toString()>();	$z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(".");	if $z0 == 0 goto $r5 = virtualinvoke r17.<java.io.File: java.lang.String toString()>();	$r5 = virtualinvoke r17.<java.io.File: java.lang.String toString()>();	$z1 = virtualinvoke $r5.<java.lang.String: boolean equals(java.lang.Object)>(".");	if $z1 == 0 goto $r6 = virtualinvoke r17.<java.io.File: java.lang.String getName()>();	$r15 = new java.io.File;	specialinvoke $r15.<java.io.File: void <init>(java.lang.String)>(r9);	return $r15
;block_num 3