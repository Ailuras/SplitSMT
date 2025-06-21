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

(declare-sort var1186 0)
(declare-sort var3149 0)
(declare-sort var3134 0)
(declare-sort var498 0)
(declare-sort var355 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var3149_getName/-1350783776 (var3149) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var355_toURI/-1753049490 (String) var498)
(declare-const null-var1186 var1186)
(declare-const null-var3149 var3149)
(declare-const null-String String)
(declare-const var2658 var1186) ; Statement: r12 := @this: org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl 
(assert (not (= var2658 null-var1186)))
(declare-const var3315 var3149) ; Statement: r1 := @parameter0: javax.tools.JavaFileManager$Location 
(assert (not (= var3315 null-var3149)))
(declare-const var2275 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var2275 null-String)))
(declare-const var367 String) ; Statement: r7 := @parameter2: java.lang.String 
(assert (not (= var367 null-String)))
(define-const var2912 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2912)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2912!1 String)
(assert (= var2912!1 ""))
(define-const var1369 String (var3149_getName/-1350783776 var3315)) ; Statement: $r2 = interfaceinvoke r1.<javax.tools.JavaFileManager$Location: java.lang.String getName()>() 
(assert true)
(define-const var1240 String (append/672562846 var2912!1 var1369)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2912!2 String)
(assert (= var2912!2 (str.++ var2912!1 var1369)))
(assert true)
(define-const var2252 String (append/-1166366385 var1240 47)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47) 
(declare-const var1240!1 String)
(assert (str.prefixof var1240 var1240!1))
(assert true)
(define-const var2246 String (append/672562846 var2252 var2275)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var2252!1 String)
(assert (= var2252!1 (str.++ var2252 var2275)))
(assert true)
(define-const var1030 String (append/-1166366385 var2246 47)) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47) 
(declare-const var2246!1 String)
(assert (str.prefixof var2246 var2246!1))
(assert true)
(define-const var1940 String (append/672562846 var1030 var367)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7) 
(declare-const var1030!1 String)
(assert (= var1030!1 (str.++ var1030 var367)))
(assert true)
(define-const var1401 String (toString/-2075883882 var1940)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2076 var498 (var355_toURI/-1753049490 var1401)) ; Statement: $r11 = staticinvoke <org.apache.dubbo.common.compiler.support.ClassUtils: java.net.URI toURI(java.lang.String)>($r10) 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var3149_getName/-1350783776=([javax.tools.JavaFileManager$Location], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var355_toURI/-1753049490=([java.lang.String], java.net.URI)}
; {var1186=org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl, var2658=r12, var3149=javax.tools.JavaFileManager$Location, var3315=r1, var2275=r4, var3134=null_type, var367=r7, var2912=$r0, var1369=$r2, var1240=$r3, var2252=$r5, var2246=$r6, var1030=$r8, var1940=$r9, var1401=$r10, var498=java.net.URI, var355=org.apache.dubbo.common.compiler.support.ClassUtils, var2076=$r11}
; {org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl=var1186, r12=var2658, javax.tools.JavaFileManager$Location=var3149, r1=var3315, r4=var2275, null_type=var3134, r7=var367, $r0=var2912, $r2=var1369, $r3=var1240, $r5=var2252, $r6=var2246, $r8=var1030, $r9=var1940, $r10=var1401, java.net.URI=var498, org.apache.dubbo.common.compiler.support.ClassUtils=var355, $r11=var2076}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r12 := @this: org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl;	r1 := @parameter0: javax.tools.JavaFileManager$Location;	r4 := @parameter1: java.lang.String;	r7 := @parameter2: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = interfaceinvoke r1.<javax.tools.JavaFileManager$Location: java.lang.String getName()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	$r11 = staticinvoke <org.apache.dubbo.common.compiler.support.ClassUtils: java.net.URI toURI(java.lang.String)>($r10);	return $r11
;block_num 1