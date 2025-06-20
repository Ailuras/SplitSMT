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

(declare-sort var1060 0)
(declare-sort var2290 0)
(declare-sort var1422 0)
(declare-sort var3640 0)
(declare-sort var445 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun mapping/1353866828 (var1060) var2290)
(declare-fun append/-1031950772 (String var1422) String)
(declare-fun cast-from-var2290-to-var1422 (var2290) var1422)
(declare-fun meta/1353866828 (var1060) var3640)
(declare-fun getMethod/1408216999 (var3640) var445)
(declare-fun cast-from-var445-to-var1422 (var445) var1422)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1060 var1060)
(declare-const var3280 var1060) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Candidate 
(assert (not (= var3280 null-var1060)))
(define-const var1835 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1835)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1835!1 String)
(assert (= var1835!1 ""))
(assert true)
(define-const var429 String (append/672562846 var1835!1 "Candidate{mapping=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Candidate{mapping=") 
(declare-const var1835!2 String)
(assert (= var1835!2 (str.++ var1835!1 "Candidate{mapping=")))
(define-const var1550 var2290 (mapping/1353866828 var3280)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Candidate: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping mapping> 
(assert true)
(define-const var846 String (append/-1031950772 var429 (cast-from-var2290-to-var1422 var1550))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var429!1 String)
(assert (str.prefixof var429 var429!1))
(assert true)
(define-const var2725 String (append/672562846 var846 ", method=")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method=") 
(declare-const var846!1 String)
(assert (= var846!1 (str.++ var846 ", method=")))
(define-const var2830 var3640 (meta/1353866828 var3280)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Candidate: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta meta> 
(assert true)
(define-const var2532 var445 (getMethod/1408216999 var2830)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta getMethod()>() 
(assert true)
(define-const var3866 String (append/-1031950772 var2725 (cast-from-var445-to-var1422 var2532))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6) 
(declare-const var2725!1 String)
(assert (str.prefixof var2725 var2725!1))
(assert true)
(define-const var1016 String (append/-1166366385 var3866 125)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var3866!1 String)
(assert (str.prefixof var3866 var3866!1))
(assert true)
(define-const var321 String (toString/-2075883882 var1016)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), mapping/1353866828=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Candidate], org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2290-to-var1422=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping], java.lang.Object), meta/1353866828=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Candidate], org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta), getMethod/1408216999=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta], org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta), cast-from-var445-to-var1422=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1060=org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Candidate, var3280=r1, var1835=$r0, var429=$r3, var2290=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping, var1550=$r2, var1422=java.lang.Object, var846=$r4, var2725=$r7, var3640=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta, var2830=$r5, var445=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta, var2532=$r6, var3866=$r8, var1016=$r9, var321=$r10}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Candidate=var1060, r1=var3280, $r0=var1835, $r3=var429, org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping=var2290, $r2=var1550, java.lang.Object=var1422, $r4=var846, $r7=var2725, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta=var3640, $r5=var2830, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta=var445, $r6=var2532, $r8=var3866, $r9=var1016, $r10=var321}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Candidate;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Candidate{mapping=");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Candidate: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping mapping>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method=");	$r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry$Candidate: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta meta>;	$r6 = virtualinvoke $r5.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.HandlerMeta: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodMeta getMethod()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 1